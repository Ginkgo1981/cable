class CreateUserExams < ActiveRecord::Migration[5.0]
  def change
    create_table :user_exams, id: :uuid do |t|
      t.uuid :user_id
      t.uuid :exam_id
      t.text :answers, array: true
      t.text :scores, array: true
      t.integer :state
      t.timestamps
    end
  end
end
