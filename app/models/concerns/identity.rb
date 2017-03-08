module Identity
  extend ActiveSupport::Concern
  
  included do
    has_one :user, :as => :identity
    accepts_nested_attributes_for :user

    # has_many :assignments, as: :identity
    # has_many :roles, :through => :assignments
    # has_many :permissions, ->{uniq}, :through => :roles
  end

end
