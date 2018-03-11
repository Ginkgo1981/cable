# == Schema Information
#
# Table name: exams
#
#  id         :uuid             not null, primary key
#  title      :string
#  note       :string
#  tag        :text             is an Array
#  level      :integer
#  use_count  :integer
#  state      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ExamsController < ApplicationController
  before_action :find_user_by_token!, only: [:get_user_exams, :get_user_exam, :save_exam_answers]

  def get_rand_exam
    exam = Exam.rand_one
    render json: {code: 0, exam: exam.format}
  end

  # def review
  #   #双方都答对
  #   #双放都答错
  #   #本方答对,对方答错
  #   #本方答错, 对方答对
  #   exam = Exam.first
  #   questions = exam.exam_questions.map do |q|
  #     {
  #         title: q.title,
  #         correction: q.correction,
  #         scores: [0,1]
  #     }
  #   end
  #   render json: {code: 0, review_questions: questions}
  # end


  def save_exam_answers
    user_exam = UserExam.find_or_create_one! @user.id, params[:exam_id], params[:answers], params[:parent_id]
    render json: {code: 0, user_exam: user_exam}
  end

  def get_user_exam
    user_exam =  UserExam.find params[:user_exam_id]
    # render json: {code: 0, user_exam: user_exam.format_as, is_mine: user_exam.is_mine?(@user.id)}
    render json: {code: 0, user_exam: user_exam.format_as}
  end

  def get_user_exams
    user_exams = @user.user_exams
    render json: {code: 0, user_exams: user_exams.map{|user_exam| user_exam.format_as}}
  end

end
