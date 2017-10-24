# == Schema Information
#
# Table name: red_packs
#
#  id         :uuid             not null, primary key
#  user_id    :uuid
#  amount     :integer
#  event      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class RedPackTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
