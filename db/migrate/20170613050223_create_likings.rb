class CreateLikings < ActiveRecord::Migration[5.0]
  def change
    create_table :likings do |t|
      t.integer :user_id
      t.integer :likable_id
      t.string  :likable_type
      t.timestamps
    end
  end
end
