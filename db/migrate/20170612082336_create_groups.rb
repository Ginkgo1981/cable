class CreateGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups, id: :uuid do |t|
      t.string :group_no
      t.uuid :init_user_id
      t.timestamps
    end
  end
end
