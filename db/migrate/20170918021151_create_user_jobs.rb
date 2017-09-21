class CreateUserJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :user_jobs,id: :uuid  do |t|

      t.uuid :user_id
      t.uuid :resume_id
      t.uuid :job_id
      t.uuid :company_id
      t.timestamps
    end
  end
end
