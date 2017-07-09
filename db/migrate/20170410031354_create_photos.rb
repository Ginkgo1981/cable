class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos, id: :uuid do |t|
      t.string :name
      t.string :key
      t.string :img_url
      t.integer :height
      t.integer :width
      t.timestamps
    end
  end
end
