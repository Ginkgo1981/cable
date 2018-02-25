class AddLastBucketItemDateToUserCampaign < ActiveRecord::Migration[5.0]
  def change
    add_column :user_campaigns, :last_bucket_item_date, :date
  end
end
