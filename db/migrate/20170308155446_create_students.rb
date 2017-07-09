class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students, id: :uuid do |t|
      t.string :university
      t.string :major
      t.string :name
      t.timestamps
    end
  end
end
