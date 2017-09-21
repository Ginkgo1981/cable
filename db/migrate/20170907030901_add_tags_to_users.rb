class AddTagsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :industry_tags, :string, array:true
    add_column :users, :skill_tags, :string,array:true
  end
end
