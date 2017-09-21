class AddFiledsToResumeDicCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :resume_dic_experiences, :industry_id, :uuid
    add_column :resume_dic_experiences, :industry_name, :string
    add_column :resume_dic_experiences, :name, :string
    add_column :resume_dic_experiences, :content, :string
  end
end
