class CreateEducations < ActiveRecord::Migration[5.0]
  def change
    create_table :educations, id: :uuid do |t|
      t.uuid :resume_id
      t.string :university
      t.string :major
      t.string :degree
      t.text :courses, array: true
      t.text :images, array: true
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end
  end
end
