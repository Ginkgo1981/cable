class CreateBookmarkings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookmarkings, id: :uuid do |t|
      t.uuid  "user_id"
      t.uuid  "bookmarkable_id"
      t.string   "bookmarkable_type"
      t.timestamps
    end
  end
end
