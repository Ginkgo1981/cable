class AddImgToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :img, :string
  end
end
