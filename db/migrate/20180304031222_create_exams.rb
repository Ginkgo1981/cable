class CreateExams < ActiveRecord::Migration[5.0]
  def change
    create_table :exams, id: :uuid do |t|
      t.string :title
      t.string :note
      t.text :tag, array: true
      t.integer :level
      t.integer :use_count
      t.integer  :state
      t.timestamps
    end
  end
end
