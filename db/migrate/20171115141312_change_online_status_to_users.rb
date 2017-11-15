class ChangeOnlineStatusToUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :online_status
    add_column :users, :online_status, :integer, default: 0
  end
end
