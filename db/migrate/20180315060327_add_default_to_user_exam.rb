class AddDefaultToUserExam < ActiveRecord::Migration[5.0]
  def change
    change_column :user_exams, :state, :integer, default: 0
  end
end
