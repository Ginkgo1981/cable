module Taggable
  extend ActiveSupport::Concern
  
  included do
    has_many :taggs, as: :taggable
  end

end
