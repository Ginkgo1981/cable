# == Schema Information
#
# Table name: exams
#
#  id         :uuid             not null, primary key
#  title      :string
#  note       :string
#  tag        :text             is an Array
#  level      :integer
#  use_count  :integer
#  state      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ExamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
