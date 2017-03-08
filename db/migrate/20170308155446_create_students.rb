class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.integer :user_id
      t.string :province
      t.string :city
      t.string :school
      t.timestamps
    end
  end
end
