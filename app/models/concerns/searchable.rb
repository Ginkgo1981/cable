module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    include Indexing
    after_touch() { __elasticsearch__.index_document }


    settings number_of_shards: 3 do
      mappings do
        indexes :job_name, type: :string, analyzer: 'ik_smart'
        indexes :job_city, type: :string, analyzer: 'ik_smart'
        indexes :job_mini_education, type: :string, analyzer: 'ik_smart'
        indexes :job_mini_experience, type: :string, analyzer: 'ik_smart'
        indexes :job_language, type: :string, analyzer: 'ik_smart'
        indexes :job_majors, type: :string, analyzer: 'ik_smart'
        indexes :job_tags, type: :string, analyzer: 'ik_smart'
        indexes :job_tags, type: :string, analyzer: 'ik_smart'
        indexes 'company.company_name', type: :string, analyzer: 'ik_smart'
        indexes 'company.company_description', type: :string, analyzer: 'ik_smart'
      end
    end
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