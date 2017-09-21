class AddTypeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :type, :string
    remove_column :users, :identity_id
    remove_column :users, :identity_type
  end
end
