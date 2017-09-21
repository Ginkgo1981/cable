class AddNotificationMessageVersionToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :notification_message_version, :integer, default: 0
  end
end
