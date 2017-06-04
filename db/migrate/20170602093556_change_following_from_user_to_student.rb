class ChangeFollowingFromUserToStudent < ActiveRecord::Migration[5.0]
  def change
    remove_column :followings,  :user_id
    add_column :followings, :student_id, :integer
  end
end
