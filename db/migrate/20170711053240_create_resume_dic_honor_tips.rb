class CreateResumeDicHonorTips < ActiveRecord::Migration[5.0]
  def change
    create_table :resume_dic_honor_tips,  id: :uuid do |t|
      t.string :name
      t.text :tips, array: true
      t.timestamps
    end
  end
end
