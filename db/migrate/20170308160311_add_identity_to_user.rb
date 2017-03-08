class AddIdentityToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :identity_type, :string
  end
end
