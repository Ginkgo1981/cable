class CreateCampaignActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :campaign_activities, id: :uuid do |t|
      t.uuid :campaign_id
      t.uuid :user_id
      t.uuid :activity_id
      t.string :activity_type
      t.string :note
      t.integer :ord, default: 0
      t.timestamps
      t.timestamps
    end
  end
end
