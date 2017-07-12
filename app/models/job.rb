# == Schema Information
#
# Table name: jobs
#
#  id                  :uuid             not null, primary key
#  job_name            :string
#  job_salary_range    :string
#  job_recruitment_num :string
#  job_published_at    :string
#  job_type            :string
#  job_category        :string
#  job_city            :string
#  job_mini_education  :string
#  job_mini_experience :string
#  job_language        :string
#  job_description     :text
#  job_majors          :text             is an Array
#  job_tags            :text             is an Array
#  company_id          :uuid
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Job < ApplicationRecord
  include Searchable
  belongs_to :company

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


  def self.create_after_check(company_job_json) #目前实现的是 elastic search方式, 另一种方式 pg
    #company
    company_json = company_job_json.select { |k, v| k =~ /company/ }
    res_company = Company.search query: {match_phrase: {company_name: company_json['company_name']}}
    company =res_company.records.first
    if company.nil?
      company = Company.create! company_json
      puts "[cable] create-company new 0 '#{company.name}'"
    else
      puts "[cable] create-company dup 0 '#{company.name}'"
    end
    #job
    job_json = company_job_json.select{|k,v| k =~ /job/}
    res_job = Job.search \
            query: {
                bool: {
                    must: [
                        { match_phrase: { 'job_name' => job_json['job_name'] } },
                        { match_phrase: { 'company.company_name' => company.name} }
                    ]
                }
            }
    job = res_job.results.first
    if job.nil?
      job = Job.create! job_json.merge({company: company})
      puts "[cable] create-job new 0 '#{job.name}'"
    else
      puts "[cable] create-job dup 0 '#{job.name}'"
    end
  end

  def as_indexed_json(options={})
    self.as_json(
        include: {company: {only: [:company_id, :company_name, :company_city, :company_category, :company_kind, :company_scale,
                                   :company_address, :company_zip, :company_website, :company_hr, :company_mobile, :company_description,
                                   :company_tel, :company_email, :company_origin_url, :company_origin_website

        ]
        }})
  end


end
