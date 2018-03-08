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
  before_action :find_user_by_token!, only: [:get_user_exam, :save_exam_answers]

  def get_rand_exam
    exam = Exam.first
    render json: {code: 0, exam: exam.format}
  end


  def review

    #双方都答对
    #双放都答错
    #本方答对,对方答错
    #本方答错, 对方答对
    exam = Exam.first
    questions = exam.exam_questions.map do |q|
      {
          title: q.title,
          correction: q.correction,
          scores: [0,1]
      }
    end


    render json: {code: 0, review_questions: questions}
  end


  def save_exam_answers
    user_exam = UserExam.find_or_create_one! @user.id, params[:exam_id], params[:answers]
    render json: {code: 0, user_exam: user_exam}
  end

  def get_user_exam
    user_exam =  UserExam.last
    render json: {code: 0, user_exam: user_exam.format_as_parent}
  end

end
