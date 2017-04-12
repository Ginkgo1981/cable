class AddWxUserinfoToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :openweb_openid, :string
    add_column :users, :mp_openid, :string
    add_column :users, :miniapp_openid, :string
    add_column :users, :nickname, :string
    add_column :users, :country, :string
    add_column :users, :province, :string
    add_column :users, :city, :string
    add_column :users, :headimgurl, :string
    add_column :users, :language, :string
  end
end
