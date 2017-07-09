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

  def as_indexed_json(options={})
    self.as_json(
        include: { company: { only: [ :company_id, :company_name, :company_city, :company_category, :company_kind, :company_scale,
                                      :company_address, :company_zip, :company_website, :company_hr, :company_mobile, :company_description,
                                      :company_tel, :company_email, :company_origin_url, :company_origin_website

        ]
        }})
  end




end
