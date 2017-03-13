module Followable
  extend ActiveSupport::Concern
  
  included do
    has_many :followings, :as => :followable
    has_many :followed_by,-> { uniq }, :through => :followings, :class_name => :User, :source => :user
  end

end
