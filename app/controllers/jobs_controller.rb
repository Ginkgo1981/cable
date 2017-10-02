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

class JobsController < ApplicationController

  def get_job
    job = Job.find_by id: params[:id]
    render json: {code: 0, data: job.format}
  end

  def get_company
    company = Company.find_by id: params[:id]
    render json: {code: 0, data: company.format}

  end

end
