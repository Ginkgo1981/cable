# == Schema Information
#
# Table name: jobs
#
#  id                       :uuid             not null, primary key
#  job_name                 :string
#  job_salary_range         :string
#  job_recruitment_num      :string
#  job_type                 :string
#  job_category             :string
#  job_city                 :string
#  job_mini_education       :string
#  job_mini_experience      :string
#  job_language             :string
#  job_description          :text
#  job_majors               :text             is an Array
#  job_tags                 :text             is an Array
#  company_id               :uuid
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  job_origin_url           :string
#  job_origin_web_site_name :string
#  job_published_at         :date
#

class Job < ApplicationRecord
  include Searchable
  include Bookmarkable
  belongs_to :company

  has_many :user_jobs
  has_many :resumes, through: :user_jobs
  has_many :users, through: :user_jobs
  # default_scope ->{order(created_at: :desc)}

  scope :fetched_at_today, -> {where('created_at >= ? and created_at <= ?', DateTime.current.beginning_of_day, DateTime.current.end_of_day)}
  scope :published_at_today, -> {where('job_published_at >= ?', Date.current)}

  def self.distribution_by_date
    Job.fetched_at_today.order('DATE(job_published_at)').group('DATE(job_published_at)').count.map{ |date, count| {date: date.to_s, count: count}}
  end


  def self.distribution_by_job_origin_web_site_name
    Job.fetched_at_today.order('job_origin_web_site_name').group('job_origin_web_site_name').count.map{ |name, count| {site: name.to_s, count: count}}
  end

  # def self.report
  #   Job.count( :group => "DATE(job_published_at)",
  #                              :conditions => ["created_at >= ? ", DateTime.current.beginning_of_day],
  #                              :order => "DATE(created_at) ASC"
  #   ).collect do |date, count|
  #     JobCountByDate.new(date, count)
  #   end
  # end


  # Job.fetched_at_today.order("DATE(job_published_at)").group("DATE(job_published_at)").count


  EMAIL_REG = /[0-9a-zA-Z]+@[0-9a-zA-Z\.]+/
  MOBILE_REG = /[0-9]{11}/
  TEL_REG = /[0-9]{3,4}[\-\s\)]*[0-9]{8}/

  settings number_of_shards: 3 do
    mappings do
      indexes :job_name, type: :string, analyzer: 'ik_smart'
      indexes :job_city, type: :string, analyzer: 'ik_smart'
      indexes :job_mini_education, type: :string, analyzer: 'ik_smart'
      indexes :job_mini_experience, type: :string, analyzer: 'ik_smart'
      indexes :job_language, type: :string, analyzer: 'ik_smart'
      indexes :job_majors, type: :string, analyzer: 'ik_smart'
      indexes :job_tags, type: :string, analyzer: 'ik_smart'
      indexes 'company.company_name', type: :string, analyzer: 'ik_smart'
      indexes 'company.company_description', type: :string, analyzer: 'ik_smart'
    end
  end

  def format
    self.as_indexed_json
  end

  def search_definition
    definition = search {
      query do
        function_score do
          query do
            multi_match do
              query 'fixed fixie'
              operator 'or'
              fields %w[ title^10 body ]
            end
          end

          functions << {script_score: {script: '_score * doc["rating"].value'}}
        end
      end

      aggregation :tags do
        terms do
          field 'tags'
          aggregation :avg_view_count do
            avg field: 'view_count'
          end
        end
      end
      aggregation :frequency do
        date_histogram do
          field 'creation_date'
          interval 'month'
          format 'yyyy-MM'
          aggregation :comments do
            stats field: 'comment_count'
          end
        end
      end
      aggregation :comment_count_stats do
        stats field: 'comment_count'
      end
      highlight fields: {
          title: {fragment_size: 50},
          body: {fragment_size: 50}
      }
    }
  end

  def self.create_after_check(company_job_json) #目前实现的是 elastic search方式, 另一种方式 pg
    #company
    company_json = company_job_json.select { |k, v| k =~ /company/ }
    res_company = Company.search query: {match_phrase: {company_name: company_json['company_name']}}
    company =res_company.records.first
    if company.nil?

      if company_json['company_email'].blank?
        company_json['company_email'] = (company_job_json['company_description'] || '').scan(EMAIL_REG).try(:first) || (company_job_json['job_description'] || '').scan(EMAIL_REG).try(:first)
      end

      if company_json['company_hr_mobile'].blank?
        company_json['company_hr_mobile'] = (company_job_json['company_description'] || '').scan(MOBILE_REG).try(:first) || (company_job_json['job_description'] || '').scan(MOBILE_REG).try(:first)
      end

      if company_json['company_tel'].blank?
        company_json['company_tel'] = (company_job_json['company_description'] || '').scan(TEL_REG).try(:first) || (company_job_json['job_description'] || '').scan(TEL_REG).try(:first)
      end

      company = Company.create! company_json
      puts "[cable] create_company new 0 '#{company.company_name}' '#{company.company_origin_url}'"
    else
      puts "[cable] create_company dup 0 '#{company.company_name}' '#{company.company_origin_url}'"
    end
    #job
    job_json = company_job_json.select { |k, v| k =~ /job/ }
    res_job = Job.search \
            query: {
        bool: {
            must: [
                {match_phrase: {'job_name' => job_json['job_name']}},
                {match_phrase: {'company.company_name' => company.company_name}}
            ]
        }
    }
    job = res_job.results.first
    if job.nil?
      job = Job.create! job_json.merge({company: company})
      puts "[cable] create_job new 0 '#{job.job_name}' '#{job.job_origin_url}'"
    else
      puts "[cable] create_job dup 0 '#{job.job_name}' '#{job.job_origin_url}'"
    end
  end

  def as_indexed_json(options={})
    self.as_json(
        include: {company: {only: [:id, :company_name, :company_city, :company_category, :company_kind, :company_scale,
                                   :company_address, :company_zip, :company_website, :company_hr_name, :company_hr_mobile, :company_description,
                                   :company_tel, :company_email, :company_origin_url

        ]
        }})
  end




end
