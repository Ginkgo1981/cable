class ChangeDescriptionToText < ActiveRecord::Migration[5.0]
  def change
    change_column :companies, :company_description, :text
    change_column :jobs, :job_description, :text
  end
end
