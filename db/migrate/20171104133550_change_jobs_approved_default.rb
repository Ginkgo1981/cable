class ChangeJobsApprovedDefault < ActiveRecord::Migration[5.0]
  def change
    change_column :jobs, :approved, :integer, default: 0
  end
end
