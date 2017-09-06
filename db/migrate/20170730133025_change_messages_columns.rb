class ChangeMessagesColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :receiver_id, :uuid
    add_column :messages, :sender_id, :uuid
    remove_column :messages, :student_id
    remove_column :messages, :staff_id
    remove_column :messages, :direction
  end
end

