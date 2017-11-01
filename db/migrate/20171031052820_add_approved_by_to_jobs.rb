class AddApprovedByToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :approved, :integer
    add_column :jobs, :approved_by, :uuid
    add_column :jobs, :approved_at, :datetime
  end
end
