# == Schema Information
#
# Table name: exam_questions
#
#  id         :uuid             not null, primary key
#  exam_id    :uuid
#  title      :string
#  options    :text             default([]), is an Array
#  answer     :string
#  analysis   :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  idx        :integer          default(0)
#

class ExamQuestion < ApplicationRecord
  belongs_to :exam
  default_scope { order(:idx) }


  def correction
    self.options[self.answer.to_i]
  end

  def format
    {
        title: title,
        options: options.map{|op| {text: op}},
        answer: answer,
        idx: idx,
        correction: correction

    }
  end
end
