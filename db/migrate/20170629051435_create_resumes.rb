class CreateResumes < ActiveRecord::Migration[5.0]
  def change
    create_table :resumes, id: :uuid do |t|
      t.uuid :student_id
      t.string :job_intention
      t.string :job_cities
      t.string :job_kind
      t.string :job_title
      t.timestamps
    end
  end
end
