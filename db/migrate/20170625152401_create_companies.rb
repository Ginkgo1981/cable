class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
    t.string :company_name
    t.string :company_city
    t.string :company_category
    t.string :company_kind
    t.string :company_scale
    t.string :company_address
    t.string :company_zip
    t.string :company_website
    t.string :company_hr
    t.string :company_mobile
    t.string :company_description
    t.string :company_tel
    t.string :company_email
    t.string :company_origin_url
    t.string :company_origin_website
    t.timestamps
    end
  end
end
