class DeleteNameRegisterInfoFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :name
    remove_column :users, :register_status
    remove_column :users, :register_at
    remove_column :users, :device_info
  end
end
