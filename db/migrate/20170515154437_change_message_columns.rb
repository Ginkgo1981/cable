class ChangeMessageColumns < ActiveRecord::Migration[5.0]
  def change
    remove_columns :messages, :attachment_id
    remove_columns :messages, :attachment_type
    remove_columns :messages, :img
    add_column :messages, :img_url, :string
  end
end
