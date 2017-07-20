class AddJobOriginUrlToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :job_origin_url, :string
  end
end
