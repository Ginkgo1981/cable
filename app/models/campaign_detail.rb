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

class CampaignDetail < ApplicationRecord
  belongs_to :campaign
  default_scope { order(:ord) }


  def format
    {
        stype: stype,
        content: content
    }
  end

end
