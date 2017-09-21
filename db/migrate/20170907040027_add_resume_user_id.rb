class AddResumeUserId < ActiveRecord::Migration[5.0]
  def change
    add_column :resumes,:user_id, :uuid
  end
end
