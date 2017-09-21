class ChangeResumeUserIdToUuid < ActiveRecord::Migration[5.0]
  def change
    remove_column :resumes, :user_id
  end
end
