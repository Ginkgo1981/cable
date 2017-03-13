# == Schema Information
#
# Table name: users
#
#  id                        :integer          not null, primary key
#  cell                      :string(50)
#  passwd                    :string(255)
#  salt                      :string(255)
#  name                      :string(255)      default("")
#  sex                       :integer
#  email                     :string(50)
#  token                     :string(50)
#  identity_id               :string(50)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  identity_type             :string(255)
#  sms_auth_code             :string(255)
#  nick_name                 :string(255)
#  avatar_url                :string(255)
#  union_id                  :string(255)
#  mini_app_open_id          :string(255)
#  web_authorization_open_id :string(255)
#  offical_account_open_id   :string(255)
#  subscribe_at              :datetime
#  unsubscribe_at            :datetime
#  device_info               :string(255)
#  register_status           :boolean
#  register_at               :datetime
#  online_status             :boolean
#

class User < ApplicationRecord

  # has_many :sended_messages, class_name: Message
  belongs_to :identity, polymorphic: true, optional: true
  has_many :followings
  has_many :following_teachers, -> { uniq }, :source => :followable, :through => :followings, :source_type => :Teacher

  before_create :generate_sms_auth_code, :generate_token
  # has_many :bookmarking
  # has_many :bookmarking_messages, :source => :bookmarkable, :through => :bookamrkings, :source_type => :Message

  def offline
    pp '======== offline ==========='
  end

  def online
    pp ' ========== online =========='
  end

  def format
    {
        id: self.id,
        cell: self.cell,
        token: self.token,
        name: self.name,
        identity_type: self.identity_type
    }
  end

  def generate_sms_auth_code
    self.sms_auth_code = '1234'
  end

  def generate_token
    self.token = '1234567890'
  end


end
