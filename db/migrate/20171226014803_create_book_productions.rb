class CreateBookProductions < ActiveRecord::Migration[5.0]
  def change
    create_table :book_productions, id: :uuid do |t|

      t.uuid :book_id
      t.string :title
      t.date :lesson_start_at
      t.date :lesson_end_at
      t.datetime :sell_start_at
      t.datetime :sell_end_at
      t.integer :duration, default: 0
      t.text :objectives, array: true, default: []
      t.text :requirements, array: true, default: []
      t.integer :limit
      t.integer :state
      t.timestamps
    end
  end
end
