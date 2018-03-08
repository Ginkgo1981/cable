class AddParentIdToUserExams < ActiveRecord::Migration[5.0]
  def change
    add_column :user_exams, :parent_id, :uuid

  end
end
