# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  cell            :string(50)
#  sex             :integer
#  token           :string(50)
#  identity_id     :string(50)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  identity_type   :string(255)
#  union_id        :string(255)
#  subscribe_at    :datetime
#  unsubscribe_at  :datetime
#  online_status   :boolean
#  openweb_openid  :string(255)
#  mp_openid       :string(255)
#  miniapp_openid  :string(255)
#  nickname        :string(255)
#  country         :string(255)
#  province        :string(255)
#  city            :string(255)
#  headimgurl      :string(255)
#  language        :string(255)
#  name            :string(255)
#  last_message_id :integer          default(0)
#

class User < ApplicationRecord

  include BeanFamily
  scope :with_identity, ->(identity_type) { where(identity_type: identity_type) }
  belongs_to :identity, polymorphic: true, optional: true
  has_many :forms
  has_many :received_messages, class_name: Message, foreign_key: :user_id
  has_many :sended_messages, class_name: Message, foreign_key: :sender_id
  #group
  has_many :user_groups
  has_many :groups, through: :user_groups
  has_one :wishcard

  has_one :qr_code, as: :codeable

  # delegate :dsin, to: :identity
  before_create :generate_token


  def format_basic
    {
        dsin: self.dsin,
        nickname: self.nickname,
        province: self.province,
        city: self.city,
        headimgurl: self.headimgurl
    }
  end

  def membership
    {
        id: self.id,
        dsin: self.dsin,
        cell: self.cell,
        token: self.token,
        identity_type: self.identity_type,
        union_id: self.union_id,
        nickname: self.nickname,
        name: self.name,
        sex: self.name,
        province: self.province,
        city: self.city,
        headimgurl: self.headimgurl,
        identity: self.identity.format,
        wishcard: {dsin: self.wishcard.try(:dsin)},
        following_universities: self.identity.is_a?(Student) ? self.identity.following_universities.map { |u| u.format } : [] #todo refactor
    }
  end

  def allow_send_notification_message?

    #todo
    true

  end


  def allow_send_point_message?
    true

  end


  def allow_send_subscription_message?
    true

  end

  def next_notification_message
    message =
        if self.identity_type == 'Student'
         $redis.lindex 'notification_student', self.last_message_id
        else
          $redis.lindex 'notification_teacher', self.last_message_id
        end
    return nil unless message
    self.increment!(:last_message_id)
    JSON.parse(message)
  end

  def offline
    pp "[user-model] offine user_id: #{self.id}"
  end

  def online
    pp "[user-model] offine online: #{self.id}"
  end

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end

end
