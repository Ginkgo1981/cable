class CreateMajors < ActiveRecord::Migration[5.0]
  def change
    create_table :majors do |t|
      t.string 'name'
      t.string 'code'
      t.integer 'university_id'
      t.string 'goal'
      t.string 'claim'
      t.string 'course'
      t.timestamps
    end
  end
end
