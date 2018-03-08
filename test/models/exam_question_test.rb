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

require 'test_helper'

class ExamQuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
