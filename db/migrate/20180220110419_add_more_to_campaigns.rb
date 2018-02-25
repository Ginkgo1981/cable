class AddMoreToCampaigns < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :tags, :text, array:true
  end
end
