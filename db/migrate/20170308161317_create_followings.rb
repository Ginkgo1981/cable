class CreateFollowings < ActiveRecord::Migration[5.0]
  def change
    create_table :followings do |t|
      t.integer "user_id"
      t.integer "followable_id"
      t.string  "followable_type"
      t.timestamps
    end
  end
end
