# == Schema Information
#
# Table name: students
#
#  id         :uuid             not null, primary key
#  university :string
#  major      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Student < ApplicationRecord
  include Identity
  include Taggable
  include Followable

  has_many :messages
  has_many :point_messages
  has_many :notification_messages
  has_many :resumes

  delegate :headimgurl, to: :user
  delegate :nickname, to: :user
  delegate :province, to: :user
  delegate :city, to: :user


  def format
    {
        name: self.name,
        nickname: self.nickname,
        headimgurl:  self.headimgurl,
        province: self.province,
        city:  self.city,
        university: self.university,
        major: self.major
    }
  end




  # private
  # def create_welcome_message
  #   user = self.user
  #   PointMessage.create! user: user,
  #                        content: "#{user.nickname} 欢迎来到天码志愿,在这里你可以得到最新最全的招考信息,直接咨询高校老师"
  #   #todo 20170423
  #   # NotificationMessage.sync_all_to_student_redis user
  # end

end
