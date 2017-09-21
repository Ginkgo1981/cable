module Bookmarkable
  extend ActiveSupport::Concern
  
  included do
    has_many :bookmarkings
    has_many :bookmarking_jobs,  :through => :bookmarkings, :source => :bookmarkable, :source_type => :Job
    has_many :bookmarked_by, :through => :bookmarkings, :class_name => :User, :source => :user
  end

end
