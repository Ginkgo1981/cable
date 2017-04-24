class ChangeMessages < ActiveRecord::Migration[5.0]
  def change
    remove_column :messages, :receiver_id
    add_column :messages, :sender_id, :integer
    add_column :messages, :expired_at, :datetime
    add_column :messages, :state, :integer
  end
end
