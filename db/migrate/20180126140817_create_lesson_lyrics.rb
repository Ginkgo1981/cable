class CreateLessonLyrics < ActiveRecord::Migration[5.0]
  def change
    create_table :lesson_lyrics, id: :uuid do |t|
      t.uuid :lesson_id
      t.integer :ord, default: 0
      t.float :sec
      t.string :en
      t.string :sc
      t.string :css
      t.string :pic

      t.timestamps
    end
  end
end
