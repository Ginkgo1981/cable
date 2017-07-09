class CreateSkills < ActiveRecord::Migration[5.0]
  def change
    create_table :skills, id: :uuid do |t|
      t.uuid :resume_id
      t.string  :title
      t.string  :content
      t.string  :category
      t.text    :images,array: true
      t.timestamps
    end
  end
end
