module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    include Indexing
    after_touch() { __elasticsearch__.index_document }
  end

  module Indexing

    # Customize the JSON serialization for Elasticsearch
    def as_indexed_json(options={})
      self.as_json(
          include: { company: { only: [ :company_name, :company_city, :company_category, :company_kind, :company_scale,
              :company_address, :company_zip, :company_website, :company_hr, :company_mobile, :company_description,
              :company_tel, :company_email, :company_origin_url, :company_origin_website

          ]
          }})
    end
  end
end