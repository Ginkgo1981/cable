# == Schema Information
#
# Table name: companies
#
#  id                     :uuid             not null, primary key
#  company_name           :string
#  company_city           :string
#  company_category       :string
#  company_kind           :string
#  company_scale          :string
#  company_address        :string
#  company_zip            :string
#  company_website        :string
#  company_hr             :string
#  company_mobile         :string
#  company_description    :text
#  company_tel            :string
#  company_email          :string
#  company_origin_url     :string
#  company_origin_website :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class CompanySerializer < ApplicationSerializer
  attributes :id, :company_name, :company_city, :company_category, :company_kind, :company_scale, :company_address, :company_zip, :company_website, :company_hr, :company_mobile, :company_description, :company_tel, :company_email, :company_origin_url, :company_origin_website


end
