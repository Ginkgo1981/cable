class CreateWishcards < ActiveRecord::Migration[5.0]
  def change
    create_table :wishcards do |t|
      t.integer :user_id
      t.text :cities
      t.text :universities
      t.text :majors
      t.text :introdution
      t.timestamps
    end
  end
end
