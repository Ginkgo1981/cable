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
#  approved                 :integer          default(0)
#  approved_by              :uuid
#  approved_at              :datetime
#  rating                   :integer          default(0)
#

class JobsController < ApplicationController
  before_action :find_user_by_token!, only: [:update_job]
  def list
    site = params[:site]
    jobs = Job.published_within_15days.where(job_origin_web_site_name: site).order('job_published_at desc').includes(:company).page(params[:page].to_i + 1).per(20)
    count = Job.published_within_15days.where(job_origin_web_site_name: site).size
    render json: jobs,
           each_serializer: JobSerializer,
           meta: {code: 0, count: count}
  end

  def distributions
    distributions = Job.published_within_15days.distribution_by_approved
    # distributions = Job.distribution_by_job_origin_web_site_name
    render json: {code: 0, distributions: distributions}
  end


  def update_job
    job = Job.find_by id: params[:id]
    job.update! params.permit(:rating, :job_name, :job_salary_range, :job_recruitment_num, :job_type, :job_category, :job_city, :job_mini_education, :job_mini_experience, :job_language, :job_description, :job_majors, :job_tags)
    company = job.company
    company.update! params[:company].permit(:company_name, :company_city, :company_category, :company_kind, :company_scale, :company_address, :company_zip, :company_website, :company_description, :company_tel, :company_email, :company_hr_name, :company_hr_mobile)
    Job.approve! job, @user
    render json: {code: 0, msg: 'succ'}
  end

  def get_job
    job = Job.find_by id: params[:id]
    render json: {code: 0, data: job.format}
  end

  def get_company
    company = Company.find_by id: params[:id]
    render json: {code: 0, data: company.format}

  end

  def get_by_redis_key
    jobs = []
    raw = $redis_jobs.get params[:key]

    if raw
      jobs = JSON.parse raw
      render json: {code: 0, jobs: jobs}
    else
      render json: {code: -1, jobs: jobs}

    end
  end

end
