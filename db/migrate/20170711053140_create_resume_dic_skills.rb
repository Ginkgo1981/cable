class CreateResumeDicSkills < ActiveRecord::Migration[5.0]
  def change
    create_table :resume_dic_skills, id: :uuid do |t|
      t.string :name
      t.timestamps
    end
  end
end
