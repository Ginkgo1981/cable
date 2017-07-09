class CreateStories < ActiveRecord::Migration[5.0]
  def change
    create_table :stories, id: :uuid do |t|
      t.string :title
      t.string :description
      t.text :content
      t.string :coverage_img_url
      t.uuid :user_id
      t.timestamps
    end
  end
end
