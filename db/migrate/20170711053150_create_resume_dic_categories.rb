class CreateResumeDicCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :resume_dic_categories, id: :uuid do |t|
      t.string :name
      t.timestamps
    end
  end
end
