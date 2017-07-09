class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs, id: :uuid do |t|
      t.string :job_name
      t.string :job_salary_range
      t.string :job_recruitment_num
      t.string :job_published_at
      t.string :job_type
      t.string :job_category
      t.string :job_city
      t.string :job_mini_education
      t.string :job_mini_experience
      t.string :job_language
      t.text :job_description
      t.text :job_majors, array: true
      t.text :job_tags, array: true
      t.uuid :company_id
      t.timestamps
    end
  end
end
