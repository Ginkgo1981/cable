class CreateResumeDicExperiences < ActiveRecord::Migration[5.0]
  def change
    create_table :resume_dic_experiences, id: :uuid do |t|

      t.timestamps
    end
  end
end
