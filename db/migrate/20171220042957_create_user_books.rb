class CreateUserBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :user_books, id: :uuid do |t|
      t.uuid :user_id
      t.uuid :book_id
      t.date :begin_at
      t.date :end_at
      t.integer :state
      t.timestamps
    end
  end
end
