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

class Student < User
  # include Identity
  # include Taggable
  # include Followable
  #
  # has_many :messages
  # has_many :point_messages
  # has_many :notification_messages
  has_many :resumes, foreign_key: :user_id, dependent: :destroy
  #
  # delegate :headimgurl, to: :user
  # delegate :nickname, to: :user
  # delegate :province, to: :user
  # delegate :city, to: :user
  #
  #
  def format
    {
        id: self.id,
        cell: self.cell,
        name: self.name,
        nickname: self.nickname,
        headimgurl:  self.headimgurl,
        province: self.province,
        city:  self.city,
        university: self.university,
        major: self.major,
        industry_tags: self.industry_tags,
        skill_tags: self.skill_tags

    }
  end

  def format_for_sender
    {
        id: self.id,
        cell: self.cell,
        name: self.name,
        nickname: self.nickname,
        headimgurl:  self.headimgurl,
        province: self.province,
        city:  self.city,
        university: self.university,
        major: self.major,
        industry_tags: self.industry_tags,
        skill_tags: self.skill_tags

    }
  end


  #
  #
  #
  #
  # # private
  # # def create_welcome_message
  # #   user = self.user
  # #   PointMessage.create! user: user,
  # #                        content: "#{user.nickname} 欢迎来到天码志愿,在这里你可以得到最新最全的招考信息,直接咨询高校老师"
  # #   #todo 20170423
  # #   # NotificationMessage.sync_all_to_student_redis user
  # # end

end
