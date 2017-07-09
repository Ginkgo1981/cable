class ChangeFollowings < ActiveRecord::Migration[5.0]
  def change

    remove_column :followings, :student_id
    add_column :followings, :follower_id, :uuid
    add_column :followings, :follower_type, :uuid

  end
end
