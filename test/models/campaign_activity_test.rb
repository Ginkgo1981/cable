# == Schema Information
#
# Table name: campaign_activities
#
#  id              :uuid             not null, primary key
#  campaign_id     :uuid
#  user_id         :uuid
#  note            :string
#  ord             :integer          default(0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  recordable_id   :uuid
#  recordable_type :string
#

require 'test_helper'

class CampaignActivityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
