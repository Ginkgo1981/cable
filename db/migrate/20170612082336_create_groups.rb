class CreateGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.string :group_id
      t.integer :init_user_id
      t.timestamps
    end
  end
end
