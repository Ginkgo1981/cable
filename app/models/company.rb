# == Schema Information
#
# Table name: companies
#
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
#  id                     :uuid             not null, primary key
#

class Company < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks


  after_touch() { __elasticsearch__.index_document }




  settings number_of_shards: 3 do
    mappings do
      indexes :company_name, type: :string, analyzer: 'ik_smart'
      indexes :company_description, type: :string, analyzer: 'ik_smart'
    end
  end

  has_many :jobs, dependent: :destroy

  # Company.search query: { match_phrase: { company_name: '宝徽' } }
  # res = Company.search(query: { match: { company_name: '宝马' } }, highlight: {fields: {company_name: {}}}).results.first.highlight

end
