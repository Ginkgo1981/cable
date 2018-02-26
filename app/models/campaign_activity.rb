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

class CampaignActivity < ApplicationRecord

  #当用户加入campaign 时 User#join_campaign!
  #当用户完成阅读时,
  #当用户完成题目时, UserCampaign#mark_as_done

  belongs_to :campaign
  belongs_to :user

  belongs_to :recordable, :polymorphic => true, optional: true

  def format
    {
        user: user.format,
        recordable: recordable.try(:format),
        note: note,
        created_at: created_at.to_now_short
    }

  end

end
