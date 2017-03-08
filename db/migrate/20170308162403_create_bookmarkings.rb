class CreateBookmarkings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookmarkings do |t|
      t.integer  "user_id"
      t.integer  "bookmarkable_id"
      t.string   "bookmarkable_type"
      t.timestamps
    end
  end
end
