class ChangeLastMessageIdUser < ActiveRecord::Migration[5.0]
  def change
    change_column_default :users, :last_message_id, 0
  end
end
