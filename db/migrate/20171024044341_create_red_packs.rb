class CreateRedPacks < ActiveRecord::Migration[5.0]
  def change
    create_table :red_packs,id: :uuid do |t|
      t.uuid :user_id
      t.integer :amount
      t.string :event
      t.timestamps
    end
  end
end
