class CreateExamQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :exam_questions,id: :uuid do |t|
      t.uuid :exam_id
      t.string :title
      t.text :options, array: true, default: []
      t.string :answer
      t.text :analysis
      t.timestamps
    end
  end
end
