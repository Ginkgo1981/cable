# == Schema Information
#
# Table name: companies
#
#  id                  :uuid             not null, primary key
#  company_name        :string
#  company_city        :string
#  company_category    :string
#  company_kind        :string
#  company_scale       :string
#  company_address     :string
#  company_zip         :string
#  company_website     :string
#  company_description :text
#  company_tel         :string
#  company_email       :string
#  company_origin_url  :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  company_hr_name     :string
#  company_hr_mobile   :string
#

class Company < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks


  has_many :user_jobs
  has_many :resumes, through: :user_jobs
  has_many :users,  through: :user_jobs

  after_touch() { __elasticsearch__.index_document }


  settings number_of_shards: 3 do
    mappings do
      indexes :company_name, type: :string, analyzer: 'ik_smart'
      indexes :company_description, type: :string, analyzer: 'ik_smart'
    end
  end

  has_many :jobs, dependent: :destroy

  def format
    {
        company_name: company_name,
        company_city: company_city,
        company_category: company_category,
        company_kind:company_kind,
        company_scale:  company_scale,
        company_address: company_address,
        company_zip: company_zip,
        company_website: company_website,
        company_hr_name: company_hr_name,
        company_hr_mobile: company_hr_mobile,
        company_description:company_description,
        company_tel:company_tel,
        company_email: company_email,
        company_origin_url:company_origin_url
    }
  end



  # Company.search query: { match_phrase: { company_name: '宝徽' } }
  # res = Company.search(query: { match: { company_name: '宝马' } }, highlight: {fields: {company_name: {}}}).results.first.highlight


  # res_job = Job.search \
  #           query: {
  #     bool: {
  #         must: [
  #             {match_phrase: {'company.company_name' => company.company_name}}
  #         ]
  #     }
  # }
end
