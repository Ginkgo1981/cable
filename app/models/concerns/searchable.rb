module Searchable
  extend ActiveSupport::Concern
  included do
    include Elasticsearch::DSL
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    after_touch() { __elasticsearch__.index_document }
  end
  module ClassMethods
    def search_by_query(query)
      __elasticsearch__.search({
                                   sort: [
                                       {rating: {order: 'desc'}},
                                       {job_published_at: {order: 'desc'}},
                                       '_score'
                                   ],
                                   query: {
                                       bool: {
                                           must: [
                                               multi_match: {
                                                   query: query,
                                                   fields: %w(job_name^3 company.company_name^2 job_tags),
                                                   operator: 'or'
                                               },
                                           ],
                                           filter: [
                                               range: {
                                                   job_published_at: {
                                                       gte: 'now-60d/d',
                                                       lt: 'now/d'
                                                   }

                                               }

                                           ]
                                       }
                                   }
                               })
    end

    def search_by_site_name(query)
      __elasticsearch__.search({
                                   sort: [
                                       {job_published_at: {order: 'desc'}},
                                       '_score'
                                   ],
                                   query: {
                                       bool: {
                                           must: [
                                               {match_phrase: {job_origin_web_site_name: query}}

                                           ]
                                       }
                                   }
                               }
      )
    end
  end
end