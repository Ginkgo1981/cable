class CreateStories < ActiveRecord::Migration[5.0]
  def change
    create_table :stories do |t|
      t.string :title
      t.string :description
      t.text :content
      t.string :coverage_img_url
      t.integer :user_id
      t.timestamps
    end
  end
end
