class CreateSentances < ActiveRecord::Migration[5.0]
  def change
    create_table :sentances, id: :uuid do |t|
      t.uuid :term_id
      t.string :en
      t.string :zh
      t.integer :ord
      t.timestamps
    end
  end
end
