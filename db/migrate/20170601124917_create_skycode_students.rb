class CreateSkycodeStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :skycode_students do |t|
      t.integer :skycode_id
      t.integer :student_id
      t.timestamps
    end
  end
end
