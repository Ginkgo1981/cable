# == Schema Information
#
# Table name: resumes
#
#  id            :uuid             not null, primary key
#  student_id    :uuid
#  job_intention :string
#  job_cities    :string
#  job_kind      :string
#  job_title     :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class ResumesController < ApplicationController
  before_action :find_resume!, only: [:get_resume, :save_component]
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

  private
  def find_resume!
    @resume = Resume.find_by id: params[:resume_id]
  end

end
