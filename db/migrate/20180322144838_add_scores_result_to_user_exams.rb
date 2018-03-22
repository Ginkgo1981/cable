class AddScoresResultToUserExams < ActiveRecord::Migration[5.0]
  def change
    add_column :user_exams, :score_result, :integer, default: 0
  end
end
