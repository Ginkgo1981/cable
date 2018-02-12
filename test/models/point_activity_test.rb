# == Schema Information
#
# Table name: point_activities
#
#  id         :uuid             not null, primary key
#  user_id    :uuid
#  points     :integer          default(0)
#  activity   :string
#  note       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class PointActivityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
