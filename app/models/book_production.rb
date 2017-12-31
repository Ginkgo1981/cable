# == Schema Information
#
# Table name: book_productions
#
#  id              :uuid             not null, primary key
#  book_id         :uuid
#  title           :string
#  lesson_start_at :date
#  lesson_end_at   :date
#  sell_start_at   :datetime
#  sell_end_at     :datetime
#  duration        :integer          default(0)
#  objectives      :text             default([]), is an Array
#  requirements    :text             default([]), is an Array
#  limit           :integer
#  state           :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  sell_state      :integer          default(0)
#

class BookProduction < ApplicationRecord
  belongs_to :book
  def format
    {
        id: id,
        book: book.format,
        title:title,
        lesson_start_at: lesson_start_at.strftime('%Y-%m-%d'),
        lesson_end_at: lesson_end_at.strftime('%Y-%m-%d'),
        sell_start_at: sell_start_at.strftime('%Y-%m-%d'),
        sell_end_at: sell_end_at.strftime('%Y-%m-%d'),
        duration: duration,
        objectives: objectives,
        requirements: requirements,
        limit:limit,
        state: state,
        sell_state: sell_state
    }
  end


  def format_with_user user
    booked =  user.books.include? self.book
    self.format.merge({booked: booked})
  end


end
