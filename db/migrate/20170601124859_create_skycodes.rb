class CreateSkycodes < ActiveRecord::Migration[5.0]
  def change
    create_table :skycodes do |t|
      t.integer :campaign_id
      t.integer :university_id
      t.integer :teacher_id
      t.string :name
      t.string :note
      t.timestamps
    end
  end
end
