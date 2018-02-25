# == Schema Information
#
# Table name: user_campaign_progresses
#
#  id               :uuid             not null, primary key
#  user_id          :uuid
#  campaign_id      :uuid
#  bucket_id        :uuid
#  bucket_type      :string
#  bucket_item_id   :uuid
#  bucket_item_type :string
#  task_date        :date
#  task_order       :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  state            :integer          default(0)
#  answers          :text             is an Array
#

class UserCampaignProgress < ApplicationRecord

  belongs_to :user
  belongs_to :campaign
  belongs_to :bucket, :polymorphic => true
  belongs_to :bucket_item, :polymorphic => true

  default_scope -> {order('task_order, task_date')}

end
