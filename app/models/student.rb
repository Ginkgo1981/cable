# == Schema Information
#
# Table name: students
#
#  id           :integer          not null, primary key
#  school       :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  sat_score    :text(65535)
#  sat_province :string(255)
#

class Student < ApplicationRecord
  include Identity
  include BeanFamily
  include Taggable
  has_many :messages
  has_many :point_messages

  serialize :sat_score, JSON
  # todo
  # after_create_commit :create_welcome_message
  before_save :create_or_update_sat, if: :sat_score_changed?

  delegate :name, to: :user
  delegate :nickname, to: :user
  delegate :province, to: :user
  delegate :city, to: :user

  def format
    {
        dsin: self.dsin,
        school: self.school,
        sat_province: self.sat_province,
        sat_score: self.sat_score
    }
  end


  def create_or_update_sat
    self.sat_province = 'Jiangsu' if self.sat_province.nil?
    "#{self.sat_province}Sat".constantize.create!(self.sat_score.merge({student_id: self.id}))
  end


  private
  def create_welcome_message
    user = self.user
    PointMessage.create! user: user,
                         content: "#{user.nickname} 欢迎来到天码志愿,在这里你可以得到最新最全的招考信息,直接咨询高校老师"
    #todo 20170423
    # NotificationMessage.sync_all_to_student_redis user
  end

end
