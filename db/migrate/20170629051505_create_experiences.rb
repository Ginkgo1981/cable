class CreateExperiences < ActiveRecord::Migration[5.0]
  def change
    create_table :experiences, id: :uuid do |t|
      t.uuid :resume_id
      t.string  :title
      t.text    :content
      t.text    :images, array: true
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end
  end
end