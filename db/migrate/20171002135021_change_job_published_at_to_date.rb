class ChangeJobPublishedAtToDate < ActiveRecord::Migration[5.0]
  def change
    remove_column :jobs, :job_published_at
    add_column :jobs, :job_published_at, :date
  end
end
