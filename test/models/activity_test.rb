# == Schema Information
#
# Table name: activities
#
#  id         :uuid             not null, primary key
#  user_id    :uuid
#  openid     :string
#  msg_type   :string
#  event      :string
#  content    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
