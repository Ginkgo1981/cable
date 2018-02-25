class AddAnswersToUserCampaignProgress < ActiveRecord::Migration[5.0]
  def change
    remove_column :user_campaign_progresses, :sate
    add_column :user_campaign_progresses, :state, :integer, default: 0
    add_column :user_campaign_progresses, :answers, :text, array: true
  end
end
