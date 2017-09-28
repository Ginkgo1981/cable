class ChangeCompanies < ActiveRecord::Migration[5.0]
  def change

    remove_column :companies, :company_origin_website
    remove_column :companies, :company_hr
    remove_column :companies, :company_mobile

    add_column :companies, :company_hr_name, :string
    add_column :companies, :company_hr_mobile, :string

  end
end
