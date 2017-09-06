module Searchable
  extend ActiveSupport::Concern
  included do
    include Elasticsearch::DSL
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    after_touch() { __elasticsearch__.index_document }

  end
end