class AddCountsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :days_count, :integer, default: 0
    add_column :users, :words_count, :integer, default: 0
  end
end
