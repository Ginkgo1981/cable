class CreateLessons < ActiveRecord::Migration[5.0]
  def change
    create_table :lessons, id: :uuid do |t|
      t.uuid :book_id
      t.string :title_cn
      t.string :title_en
      t.string :previous
      t.string :audio_url
      t.string :audio_name
      t.text :lyric, array:true
      t.text :share_words
      t.string :share_img_url
      t.string :share_title
      t.string :teacher_notes_url
      t.integer :word_count
      t.timestamps
    end
  end
end
