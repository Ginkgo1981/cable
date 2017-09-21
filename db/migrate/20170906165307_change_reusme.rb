class ChangeReusme < ActiveRecord::Migration[5.0]
  def change
    remove_column :resumes, :student_id
    add_column :resumes, :user_id, :integer
    add_column :resumes,:university, :string
    add_column :resumes, :major, :string
  end
end
