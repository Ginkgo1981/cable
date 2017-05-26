class AddContentToMajor < ActiveRecord::Migration[5.0]
  def change
    add_column :majors,  :content, :text
  end
end
