class AddJobTagsToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :job_tags, :text
  end
end
