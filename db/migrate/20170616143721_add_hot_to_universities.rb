class AddHotToUniversities < ActiveRecord::Migration[5.0]
  def change
    add_column :universities, :hot,  :integer, default: 0
  end
end
