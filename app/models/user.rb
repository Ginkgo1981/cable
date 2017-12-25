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
#  hr_approved                  :integer          default(0)
#  hr_approved_by               :uuid
#  hr_approved_at               :datetime
#  online_status                :integer          default(0)
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
  has_many :customer_service_activities
  has_many :search_activities

  has_many :red_packs

  has_many :user_books
  has_many :books, through: :user_books

  has_many :user_lessons
  has_many :lessons, through:  :user_lessons




  scope :online, -> {where('online_status = ?', 1)}
  scope :offline, -> {where('online_status = ?', 0)}


  # delegate :dsin, to: :identity
  before_create :generate_token


  def buy_book book, begin_at
    self.books << book
    book.lessons.each_with_index do |lesson, index|
      self.user_lessons.create book: book,
          lesson: lesson,
          reading_day: index + 1,
          reading_date: (begin_at + index.day).strftime('%Y-%m-%d')
    end
  end

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
        resumes: self.type == 'Student' ? self.resumes.map(&:format) : [],
        human_resource_info: self.type == 'HumanResource' ? self.try(:human_resource_info).try(:format) : nil,
        hr_approved: self.hr_approved

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
    self.online_status = 0
    self.save!
    pp "[user-model] offine user_id: #{self.id}"

  end

  def online
    self.online_status = 1
    self.save!
    pp "[user-model] online: user_id: #{self.id}"
  end

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end

end
