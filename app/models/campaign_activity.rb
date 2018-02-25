# == Schema Information
#
# Table name: campaign_activities
#
#  id            :uuid             not null, primary key
#  campaign_id   :uuid
#  user_id       :uuid
#  activity_id   :uuid
#  activity_type :string
#  note          :string
#  ord           :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class CampaignActivity < ApplicationRecord

  belongs_to :campaign
  belongs_to :user

  belongs_to :activity, :polymorphic => true, optional: true

  def format
    {
        user: user.format,
        activity: activity.try(:format),
        note: note
    }

  end

end