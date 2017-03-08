module Bookmarkable
  extend ActiveSupport::Concern
  
  included do
    has_many :bookmarkings, :as => :bookmarkable
    has_many :bookmarked_by, :through => :bookmarkings, :class_name => :User, :source => :user
  end

end
