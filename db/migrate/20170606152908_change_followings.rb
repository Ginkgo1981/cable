class ChangeFollowings < ActiveRecord::Migration[5.0]
  def change

    remove_column :followings, :student_id
    add_column :followings, :follower_id, :string
    add_column :followings, :follower_type, :string

  end
end
