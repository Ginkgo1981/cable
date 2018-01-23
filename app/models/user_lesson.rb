# == Schema Information
#
# Table name: user_lessons
#
#  id                  :uuid             not null, primary key
#  user_id             :uuid
#  book_id             :uuid
#  lesson_id           :uuid
#  reading_day         :integer
#  reading_date        :string
#  state               :integer
#  answers             :text             is an Array
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  send_checkin_notify :integer          default(0)
#

class UserLesson < ApplicationRecord
  belongs_to :user
  belongs_to :book
  belongs_to :lesson

  before_save :change_state, if: :answers_changed?

  def mini_format
    {
        book: book.format,
        reading_day: reading_day,
        reading_date: reading_date
    }
  end

  def format
    {
        id: id,
        reading_day: reading_day,
        reading_date: reading_date,
        lesson: lesson.format,
        answers: answers,
        book: book.format
    }
  end

  def format_of_questions
    {
        id: self.id,
        day: self.reading_day,
        questions: self.lesson.lesson_questions.map { |l| l.format },
        answers: self.answers || [],
        state: self.state.to_i
    }
  end

  def change_state
    if self.answers && self.answers.size > 0
      self.state = self.reading_date == Time.now.strftime('%Y-%m-%d') ? 1 : 2
    end
  end

end

