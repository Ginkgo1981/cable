class HrController < ApplicationController

  before_action :find_user_by_token!, only: [:resumes,:receive_resume]

  def resumes
    resumes = @user.resumes
    render json: resumes,
           each_serializer: ResumeSerializer,
           meta: {code: 0}
  end

  def receive_resume
    resume = Resume.find_by id: params[:resume_id]
    if @user.is_a? HumanResource
      @user.resumes << resume unless @user.resumes.include? resume
    end
    render json: {code: 0, message: 'succ'}
  end

end
