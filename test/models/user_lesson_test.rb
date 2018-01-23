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

require 'test_helper'

class UserLessonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
