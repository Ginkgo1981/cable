# == Schema Information
#
# Table name: user_exams
#
#  id         :uuid             not null, primary key
#  user_id    :uuid
#  exam_id    :uuid
#  answers    :text             is an Array
#  scores     :text             is an Array
#  state      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :uuid
#

class UserExam < ApplicationRecord

  before_create :calculating_scores

  belongs_to :user
  belongs_to :exam

  belongs_to :parent_exam, class_name: UserExam, foreign_key: :parent_id, optional: true
  has_many :child_exams, class_name: UserExam,  foreign_key: :parent_id


  def self.find_or_create_one!(user_id, exam_id, answers)
    user_exam = self.where(user_id: user_id, exam_id: exam_id).first
    unless user_exam
      self.create! user_id: user_id,
                   exam_id: exam_id,
                   answers: answers
    end
    user_exam
  end


  def format
    {
        user: user.format,
        exam: exam.format,
        answers: answers,
        scores: scores,
        state: state
    }
  end

  def format_as_parent
    {
        mine: self.format,
        childs: self.child_exams.map(&:format)

    }
  end

  def calculating_scores
    exam_answers = self.exam.exam_questions.map{|q| q.answer.to_i}
    self.scores = self.answers.each_with_index.map{|a,idx| a.to_i == exam_answers[idx] ? 1 : 0 }
  end
end
