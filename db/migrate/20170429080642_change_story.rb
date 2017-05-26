class ChangeStory < ActiveRecord::Migration[5.0]
  def change

    add_column :stories, :teacher_id, :integer
    add_column :stories, :university_id, :integer
    add_column :stories, :staff_id, :integer

    remove_column :stories, :user_id
  end
end
