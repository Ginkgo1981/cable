# == Schema Information
#
# Table name: companies
#
#  id                     :integer          not null, primary key
#  company_name           :string(255)
#  company_city           :string(255)
#  company_category       :string(255)
#  company_kind           :string(255)
#  company_scale          :string(255)
#  company_address        :string(255)
#  company_zip            :string(255)
#  company_website        :string(255)
#  company_hr             :string(255)
#  company_mobile         :string(255)
#  company_description    :text(65535)
#  company_tel            :string(255)
#  company_email          :string(255)
#  company_origin_url     :string(255)
#  company_origin_website :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Company < ApplicationRecord


  has_many :jobs



  def as_indexed_json

  end



end
