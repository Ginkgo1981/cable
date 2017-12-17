class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books,  id: :uuid do |t|
      t.string :book_name
      t.string :book_name_cn
      t.string :book_cover_img_url
      t.timestamps
    end
  end
end
