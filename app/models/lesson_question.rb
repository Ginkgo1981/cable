# == Schema Information
#
# Table name: lesson_questions
#
#  id         :uuid             not null, primary key
#  lesson_id  :uuid
#  question   :string
#  options    :text             is an Array
#  answer     :string
#  analysis   :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LessonQuestion < ApplicationRecord

  belongs_to :lesson

  def format
    {
        question: question,
        options: options,
        answer: answer,
        analysis: analysis
    }

  end
end
