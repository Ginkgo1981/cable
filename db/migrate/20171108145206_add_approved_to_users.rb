class AddApprovedToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :hr_approved, :integer, default: 0
    add_column :users, :hr_approved_by, :uuid
    add_column :users, :hr_approved_at, :datetime
  end
end
