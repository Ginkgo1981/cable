module Identity
  extend ActiveSupport::Concern
  
  included do
    has_one :user, :as => :identity, dependent: :destroy
    accepts_nested_attributes_for :user
  end

end
