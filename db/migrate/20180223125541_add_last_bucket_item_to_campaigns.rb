class AddLastBucketItemToCampaigns < ActiveRecord::Migration[5.0]
  def change
    add_column :user_campaigns, :last_bucket_item_id,:uuid
    add_column :user_campaigns, :last_bucket_item_type,:string
    add_column :user_campaigns, :done_items_count, :integer, default: 0
    add_column :user_campaigns, :total_items_count, :integer, default: 0
    add_column :user_campaigns, :mark_as_deleted, :boolean, default: false
  end
end
