class CreateHrResumes < ActiveRecord::Migration[5.0]
  def change
    create_table :hr_resumes,id: :uuid do |t|
      t.uuid :hr_id
      t.uuid :resume_id
      t.integer :state
      t.timestamps
    end
  end
end
