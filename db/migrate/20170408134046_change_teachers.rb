class ChangeTeachers < ActiveRecord::Migration[5.0]
  def change
    remove_column :teachers, :yxmc
    remove_column :teachers, :yxdm
    add_column :teachers, :university_id, :integer
  end
end
