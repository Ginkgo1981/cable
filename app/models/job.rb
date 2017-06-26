# == Schema Information
#
# Table name: jobs
#
#  id                  :integer          not null, primary key
#  job_name            :string(255)
#  job_salary_range    :string(255)
#  job_recruitment_num :string(255)
#  job_published_at    :string(255)
#  job_type            :string(255)
#  job_category        :string(255)
#  job_city            :string(255)
#  job_mini_education  :string(255)
#  job_mini_experience :string(255)
#  job_language        :string(255)
#  job_description     :text(65535)
#  job_majors          :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  company_id          :integer
#  job_tags            :text(65535)
#

class Job < ApplicationRecord
  include Searchable
  belongs_to :company

  serialize :job_tags, Array


  def self.create_from_json json



  end




end
