# == Schema Information
#
# Table name: users
#
#  id                           :uuid             not null, primary key
#  cell                         :string(50)
#  sex                          :integer
#  token                        :string(50)
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  union_id                     :string
#  subscribe_at                 :datetime
#  unsubscribe_at               :datetime
#  device_info                  :string
#  register_status              :boolean
#  register_at                  :datetime
#  online_status                :boolean
#  openweb_openid               :string
#  mp_openid                    :string
#  miniapp_openid               :string
#  nickname                     :string
#  country                      :string
#  province                     :string
#  city                         :string
#  headimgurl                   :string
#  language                     :string
#  name                         :string
#  latitude                     :float
#  longitude                    :float
#  type                         :string
#  university                   :string
#  major                        :string
#  industry_tags                :string           is an Array
#  skill_tags                   :string           is an Array
#  notification_message_version :integer          default(0)
#  role                         :integer          default(0)
#  avatar                       :string
#

class User < ApplicationRecord

  include Bookmarkable
  # include Likable

  has_many :forms
  has_many :received_messages, class_name: Message, foreign_key: :user_id
  has_many :sended_messages, class_name: Message, foreign_key: :sender_id
  has_many :user_groups
  has_many :groups, through: :user_groups
  has_one  :qr_code, as: :codeable

  has_many :user_jobs
  has_many :jobs, through: :user_jobs
  has_many :companies, through: :user_jobs

  has_many :invitings, foreign_key: :inviter_id
  has_many :invitees, through: :invitings, class_name: User

  has_many :red_packs



  # delegate :dsin, to: :identity
  before_create :generate_token

  def format
    {
        id: self.id,
        nickname: self.nickname,
        province: self.province,
        city: self.city,
        headimgurl: self.headimgurl,
        type: self.type
    }
  end


  def membership
    {
        id: self.id,
        cell: self.cell,
        token: self.token,
        type: self.type,
        union_id: self.union_id,
        name: self.name,
        nickname: self.nickname,
        sex: self.sex,
        province: self.province,
        city: self.city,
        headimgurl: self.headimgurl,
        avatar: self.avatar,
        latitude: self.latitude,
        longitude: self.longitude,
        role: self.role,
        resumes: self.type == 'Student' ? self.resumes.map(&:format) : []
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
        if self.type == 'Student'
          $redis_cable.lindex 'notification_messages_to_student_list', self.notification_message_version
        # else
        #   $redis.lindex 'notification_teacher', self.notification_message_version
        end
    return nil unless message
    self.increment!(:notification_message_version)
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
