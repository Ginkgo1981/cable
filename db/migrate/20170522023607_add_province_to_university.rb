class AddProvinceToUniversity < ActiveRecord::Migration[5.0]
  def change
    add_column :universities, :province, :string
  end
end
