class CreateCampaigns < ActiveRecord::Migration[5.0]
  def change
    create_table :campaigns, id: :uuid do |t|
      t.uuid :bucket_id
      t.string :bucket_type
      t.date :start_at
      t.date :end_at
      t.integer :duration
      t.integer :sell_state
      t.integer :completed_days
      t.integer :missed_days
      t.timestamps
    end
  end
end
