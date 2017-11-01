class AddRatingToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :rating, :integer, default: 0
  end
end
