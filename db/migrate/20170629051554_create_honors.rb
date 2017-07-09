class CreateHonors < ActiveRecord::Migration[5.0]
  def change
    create_table :honors, id: :uuid do |t|
      t.uuid :resume_id
      t.string  :title
      t.text  :content
      t.datetime :start_date
      t.datetime :end_date
      t.text :images, array: true
      t.timestamps
    end
  end
end
