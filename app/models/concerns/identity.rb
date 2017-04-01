module Identity
  extend ActiveSupport::Concern
  
  included do
    has_one :user, :as => :identity
    accepts_nested_attributes_for :user
    # has_one :bean, through: :user
    # delegate :dsin, to: :user, allow_nil: true
    # has_many :assignments, as: :identity
    # has_many :roles, :through => :assignments
    # has_many :permissions, ->{uniq}, :through => :roles
  end


  def test

    Student.create! province: 'jianshu',
                    city: 'nanjing',
                    school: 'the first school',
                    user_attributes: {
                        cell: '13813813801',
                        name: 'chenjian01'
                    }
  end

end
