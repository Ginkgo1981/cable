class ChangeCampaignActivities < ActiveRecord::Migration[5.0]
  def change

    remove_column :campaign_activities, :activity_id
    remove_column :campaign_activities, :activity_type

    add_column :campaign_activities, :recordable_id, :uuid
    add_column :campaign_activities, :recordable_type, :string
  end
end
