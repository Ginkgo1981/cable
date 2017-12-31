class CreateLessonWords < ActiveRecord::Migration[5.0]
  def change
    create_table :lesson_words, id: :uuid do |t|
      t.uuid :lesson_id
      t.string :word
      t.string :mean
      t.string :accent
      t.integer :level
      t.string :audio_url
      t.timestamps
    end
  end
end
