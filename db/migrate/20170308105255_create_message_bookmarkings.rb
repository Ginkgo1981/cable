class CreateMessageBookmarkings < ActiveRecord::Migration[5.0]
  def change
    create_table :message_bookmarkings, id: :uuid do |t|
      t.uuid  "message_id"
      t.uuid  "user_id"
      t.timestamps
    end
  end
end
