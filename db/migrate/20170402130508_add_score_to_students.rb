class AddScoreToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :sat_score, :text
  end
end
