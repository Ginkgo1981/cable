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

require 'test_helper'

class LessonQuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
