class CreateLikings < ActiveRecord::Migration[5.0]
  def change
    create_table :likings,id: :uuid do |t|
      t.uuid :user_id
      t.uuid :likable_id
      t.string  :likable_type
      t.timestamps
    end
  end
end
