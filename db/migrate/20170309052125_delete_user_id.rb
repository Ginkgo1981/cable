class DeleteUserId < ActiveRecord::Migration[5.0]
  def change

    remove_column :teachers, :user_id
    remove_column :staffs, :user_id
    remove_column :students, :user_id

  end
end
