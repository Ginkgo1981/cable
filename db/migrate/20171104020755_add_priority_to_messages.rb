class AddPriorityToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :priority, :integer, default: 0
  end
end
