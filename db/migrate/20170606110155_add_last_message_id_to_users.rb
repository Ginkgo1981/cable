class AddLastMessageIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :last_message_id, :integer
  end
end
