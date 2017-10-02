# == Schema Information
#
# Table name: jobs
#
#  id                       :uuid             not null, primary key
#  job_name                 :string
#  job_salary_range         :string
#  job_recruitment_num      :string
#  job_published_at         :string
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
#

class JobSerializer < ApplicationSerializer
  attributes :id, :job_name, :job_salary_range, :job_recruitment_num, :job_published_at, :job_type,:job_category, :job_city, :job_mini_education, :job_mini_experience, :job_language,:job_origin_url
  belongs_to :company

end
