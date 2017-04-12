class DeleteUselessColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :passwd
    remove_column :users, :salt
    remove_column :users, :email
    remove_column :users, :sms_auth_code
    remove_column :users, :nick_name
    remove_column :users, :avatar_url
    remove_column :users, :mini_app_open_id
    remove_column :users, :web_authorization_open_id
    remove_column :users, :offical_account_open_id

  end
end
