class CreateUserLessons < ActiveRecord::Migration[5.0]
  def change
    create_table :user_lessons, id: :uuid do |t|
      t.uuid :user_id
      t.uuid :book_id
      t.uuid :lesson_id
      t.integer :reading_day
      t.string :reading_date
      t.integer :state
      t.text :answers, array: true
      t.timestamps
    end
  end
end
