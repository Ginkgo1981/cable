class CreateCampaignDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :campaign_details, id: :uuid do |t|
      t.uuid :campaign_id
      t.integer :ord, default: 0
      t.string :stype
      t.string :content
      t.timestamps
    end
  end
end
