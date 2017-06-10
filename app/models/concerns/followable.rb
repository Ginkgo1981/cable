module Followable
  extend ActiveSupport::Concern
  
  # included do
  #   has_many :followings, :as => :followable
  #   has_many :students,-> { uniq }, :through => :followings, :class_name => :Student, :source => :student
  # end

end
