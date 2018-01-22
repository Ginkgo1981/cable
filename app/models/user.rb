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

  has_many :user_books, dependent: :destroy
  has_many :books, through: :user_books

  has_many :user_lessons, dependent: :destroy
  has_many :lessons, through:  :user_lessons

  has_many :talk_threads




  scope :online, -> {where('online_status = ?', 1)}
  scope :offline, -> {where('online_status = ?', 0)}


  # delegate :dsin, to: :identity
  before_create :generate_token


  def mp?
    self.mp_openid.present?
  end


  def stats
    word_counts = self.user_lessons.where(state: 1).map{|ul| ul.lesson.word_count}.sum
    reading_day_count =  self.user_lessons.where(state: 1).count
    {word_counts: word_counts, reading_day_count: reading_day_count}
  end


  def buy_book_producton book_production
    book = book_production.book
    raise CableException::DuplicatedLesson if self.books.include? book
    if self.user_books.maximum(:end_at) && self.user_books.maximum(:end_at) > book_production.lesson_start_at
      raise CableException::OngoingLesson
    end
    self.user_books.create!  book: book,
                             begin_at: book_production.lesson_start_at,
                             end_at: book_production.lesson_end_at
    book.lessons.each_with_index do |lesson, idx|
      self.user_lessons.create! book: book,
          lesson: lesson,
          reading_day: idx + 1,
          reading_date: (book_production.lesson_start_at + idx.day).strftime('%Y-%m-%d')
    end
    true
  end


  def remove_all_lessons
    self.user_books.each &:destroy
    self.user_lessons.each &:destroy
  end

  def share_info #打卡内容
    {
        id: self.id,
        nickname: self.nickname,
        province: self.province,
        city: self.city,
        headimgurl: self.headimgurl,
        type: self.type,
        stats: self.stats
    }
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
