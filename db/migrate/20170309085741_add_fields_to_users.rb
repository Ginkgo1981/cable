class AddFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :sms_auth_code, :string
    add_column :users, :nick_name, :string
    add_column :users, :avatar_url, :string
    add_column :users, :union_id, :string
    add_column :users, :mini_app_open_id, :string
    add_column :users, :web_authorization_open_id, :string
    add_column :users, :offical_account_open_id, :string
    add_column :users, :subscribe_at, :datetime
    add_column :users, :unsubscribe_at, :datetime
    add_column :users, :device_info, :string
    add_column :users, :register_status, :boolean
    add_column :users, :register_at, :datetime
    add_column :users, :online_status, :boolean
  end
end
