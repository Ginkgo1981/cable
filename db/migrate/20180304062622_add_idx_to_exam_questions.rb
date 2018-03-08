class AddIdxToExamQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :exam_questions, :idx, :integer, default: 0
  end
end
