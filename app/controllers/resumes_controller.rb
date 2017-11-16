# == Schema Information
#
# Table name: resumes
#
#  id            :uuid             not null, primary key
#  job_intention :string
#  job_cities    :string
#  job_kind      :string
#  job_title     :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  university    :string
#  major         :string
#  user_id       :uuid
#

class ResumesController < ApplicationController
  before_action :find_resume!, only: [:get_resume, :save_component, :show_intention,:save_intention]
  before_action :find_user_by_token!, only: [:my_resumes, :create_resume]


  def my_resumes #only 1 now
    if @student
      resume = @student.resumes[0]

      render json: {code: 0, resume: resume.format_for_basic}
      # render json: resumes,
      #        each_serializer: ResumeSerializer,
      #        meta: {code: 0}
    end
  end

  # def create_resume
  #   if @student
  #     resume = @student.resumes.create! university: params[:university],
  #                                       job_cities: params[:city],
  #                                       job_kind: '全职',
  #                                       job_intention: '找工作中',
  #                                       job_title: params[:job_title],
  #                                       major: params[:major]
  #     render json: {code: 0, data: resume.format}
  #   end
  #
  # end

  def get_resume
    render json: {code: 0, data: @resume.format}
  end


  def save_component
    p = params[:entity].permit(:id, :university, :major, :start_date, :end_date, :degree, :title, :content,:images).to_h
    if p[:id]
      entity = params[:type].constantize.find_by id: p[:id]
      entity.update p.except(:id)
    else
      params[:type].constantize.create! p.merge({resume: @resume})
    end
    SlackSendJob.perform_later("[cable] 修改简历 #{params[:type]} #{@resume.student.nickname}")

    render json: {code: 0, msg: 'succ'}
  end

  def delete_component
    entity = params[:type].constantize.find_by id: params[:id]
    entity.destroy if entity
    render json: {code: 0, msg: 'succ'}
  end

  def show_component
    entity = params[:type].constantize.find_by id: params[:id]
    render json: {code: 0, data: entity.format}
  end


  def show_intention
    #todo just show intent, NOT relationship present
    render json: {code: 0, data: @resume.format}
  end

  def save_intention
    resume = @resume.update! params[:resume].permit(:id,:university,:major, :job_title, :job_intention, :job_cities, :job_kind,).to_h
    SlackSendJob.perform_later("[cable] 修改简历 #{resume.student.nickname}")
    render json: {code: 0, data: @resume.format}
  end

  private
  def find_resume!
    @resume = Resume.find_by id: params[:resume_id]
  end

end


