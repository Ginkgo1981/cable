# == Schema Information
#
# Table name: campaign_details
#
#  id          :uuid             not null, primary key
#  campaign_id :uuid
#  ord         :integer          default(0)
#  stype       :string
#  content     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class CampaignDetailTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
