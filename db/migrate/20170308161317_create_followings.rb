class CreateFollowings < ActiveRecord::Migration[5.0]
  def change
    create_table :followings, id: :uuid do |t|
      t.uuid "user_id"
      t.uuid "followable_id"
      t.string  "followable_type"
      t.timestamps
    end
  end
end
