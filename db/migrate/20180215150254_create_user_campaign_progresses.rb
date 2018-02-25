class CreateUserCampaignProgresses < ActiveRecord::Migration[5.0]
  def change
    create_table :user_campaign_progresses, id: :uuid do |t|
      t.uuid :user_id
      t.uuid :campaign_id
      t.uuid :bucket_id
      t.string :bucket_type
      t.uuid :bucket_item_id
      t.string :bucket_item_type
      t.date :task_date
      t.integer :task_order
      t.integer :sate
      t.timestamps
    end
  end
end
