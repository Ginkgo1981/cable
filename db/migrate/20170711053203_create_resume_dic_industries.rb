class CreateResumeDicIndustries < ActiveRecord::Migration[5.0]
  def change
    create_table :resume_dic_industries, id: :uuid do |t|

      t.string :name
      t.string :q_uuid
      t.timestamps
    end
  end
end
