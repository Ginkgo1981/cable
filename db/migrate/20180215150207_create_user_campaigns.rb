class CreateUserCampaigns < ActiveRecord::Migration[5.0]
  def change
    create_table :user_campaigns, id: :uuid do |t|
      t.uuid :user_id
      t.uuid :campaign_id
      t.uuid :bucket_id
      t.string :bucket_type
      t.timestamps
    end
  end
end
