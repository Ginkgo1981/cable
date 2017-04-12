class AddCollumnsToTeachers < ActiveRecord::Migration[5.0]
  def change
    add_column :teachers, :cell, :string
    add_column :teachers, :name, :string
    add_column :teachers, :duty, :string
    add_column :teachers, :status, :integer
  end
end
