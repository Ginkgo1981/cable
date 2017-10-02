class AddJobOriginWebSiteNameToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :job_origin_web_site_name, :string
  end
end
