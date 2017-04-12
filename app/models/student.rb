# == Schema Information
#
# Table name: students
#
#  id           :integer          not null, primary key
#  province     :string(255)
#  city         :string(255)
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

  serialize :sat_score, JSON

  after_create_commit :create_welcome_message

  before_save :create_or_update_sat, if: :sat_score_changed?

  def create_or_update_sat
    if self.sat_province.nil?
      self.sat_province = 'Jiangsu'
    end
    "#{self.sat_province}Sat".constantize.create! self.sat_score
  end

  def t

    sta_score = {
        score_chinese: 120,
        score_english: 110,
        score_math: 100,
        score_sum: 330,
        kl: 'kl',
        km_1: 'km_1',
        km_2: 'km_2',
        score_km_1: 'A+',
        score_km_2: 'B'
    }

  end


  private
  def create_welcome_message
    user = self.user
    PointMessage.create! user: user,
                         content: "#{user.name} 欢迎来到志愿百分百,在这里你可以得到最新最全的招考信息,直接咨询高校老师",
                         receiver: user
    NotificationMessage.sync_all_to_student_redis user
  end

end
