class CreateLessonQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :lesson_questions,id: :uuid do |t|
      t.uuid :lesson_id
      t.string :question
      t.text :options, array: true
      t.string :answer
      t.text :analysis
      t.timestamps      t.timestamps
    end
  end
end
