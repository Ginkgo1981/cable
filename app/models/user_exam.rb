# == Schema Information
#
# Table name: user_exams
#
#  id         :uuid             not null, primary key
#  user_id    :uuid
#  exam_id    :uuid
#  answers    :text             is an Array
#  scores     :text             is an Array
#  state      :integer          default("wait")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :uuid
#

class UserExam < ApplicationRecord

  before_create :calculating_scores, :update_state

  enum state: [:wait, :completed]

  belongs_to :user
  belongs_to :exam

  belongs_to :parent_exam, class_name: UserExam, foreign_key: :parent_id, optional: true
  has_one :child_exam, class_name: UserExam,  foreign_key: :parent_id

  def self.get_wait_one(user_id)
    UserExam.where('state = 0 and user_id != ?', user_id).first
  end

  def self.find_or_create_one!(user_id, exam_id, answers, parent_id)
    user_exam = self.where(user_id: user_id, exam_id: exam_id).first
    unless user_exam
      user_exam = self.create! user_id: user_id,
                   exam_id: exam_id,
                   answers: answers,
                   parent_id: parent_id

    end
    user_exam
  end


  def format
    {
        id: self.id,
        user: user.format,
        exam: exam.format,
        answers: answers,
        scores: scores,
        state: state,
        created_at: self.created_at.to_now_short
    }
  end

  def is_mine?(user_id)
    user_id == self.user_id ? true : false
  end

  def correct_scores_num
    self.scores.select{|s| s.to_i == 1}.size
  end

  def offense?
    !self.parent_exam
  end

  def defense?
    !!self.parent_exam
  end

  def scores_result
    base_exam  =  self.parent_exam || self.child_exam
    if base_exam
      if self.correct_scores_num > base_exam.correct_scores_num
        'win'
      elsif self.correct_scores_num == base_exam.correct_scores_num
        'equal'
      else
        'lose'
      end
    else
      'unknow'
    end
  end

  def format_as
    self.parent_exam ? format_as_defense : format_as_offense
  end


  def format_as_offense
    {
        id: self.id,
        scores_result: self.scores_result,
        exam: exam.format,
        offense: self.format,
        defense: self.child_exam.try(:format),
        state: self.state
    }
  end


  def format_as_defense
    {
        id: self.id,
        scores_result: self.scores_result,
        exam: exam.format,
        offense: self.parent_exam.try(:format),
        defense: self.format,
        state: self.state
    }
  end

  def calculating_scores
    exam_answers = self.exam.exam_questions.map{|q| q.answer.to_i}
    self.scores = self.answers.each_with_index.map{|a,idx| a.to_i == exam_answers[idx] ? 1 : 0 }
  end

  def update_state
    if self.parent_exam.present? || self.child_exam.present?
      self.state = 'completed'
      self.parent_exam&.update state: 'completed'
      self.child_exam&.update state: 'completed'
    end
  end
end
