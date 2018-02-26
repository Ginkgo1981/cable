# == Schema Information
#
# Table name: user_campaigns
#
#  id                    :uuid             not null, primary key
#  user_id               :uuid
#  campaign_id           :uuid
#  bucket_id             :uuid
#  bucket_type           :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  last_bucket_item_id   :uuid
#  last_bucket_item_type :string
#  done_items_count      :integer          default(0)
#  total_items_count     :integer          default(0)
#  mark_as_deleted       :boolean          default(FALSE)
#  last_bucket_item_date :date
#

class UserCampaign < ApplicationRecord

  belongs_to :user
  belongs_to :campaign
  belongs_to :bucket, :polymorphic => true
  belongs_to :last_bucket_item, :polymorphic => true, optional: true





  def next_bucket_item
    if last_bucket_item.present?
      if last_bucket_item_date == Time.current.to_date
        return 1, last_bucket_item #每天只能读一篇
      else
        return 0, last_bucket_item.next
      end
    else
      return 0, bucket.first_bucket_item
    end
  end


  def mark_as_done bucket_item, answers=[]
    self.last_bucket_item = bucket_item
    self.last_bucket_item_date = Time.current.to_date
    self.done_items_count += 1
    self.save!
    UserCampaignProgress.create! campaign: campaign,
                                 user: user,
                                 bucket: bucket,
                                 bucket_item: bucket_item,
                                 task_order: done_items_count,
                                 task_date: Time.current.to_date,
                                 answers: answers
    CampaignActivity.create! campaign: campaign,
                             user: user,
                             note: "#{user.nickname} 完成了#{campaign.name}--第#{done_items_count}关"

  end

end
