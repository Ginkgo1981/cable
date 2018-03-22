# == Schema Information
#
# Table name: user_exams
#
#  id           :uuid             not null, primary key
#  user_id      :uuid
#  exam_id      :uuid
#  answers      :text             is an Array
#  scores       :text             is an Array
#  state        :integer          default("wait")
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  parent_id    :uuid
#  score_result :integer          default("unknow")
#

require 'test_helper'

class UserExamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
