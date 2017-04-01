# == Schema Information
#
# Table name: students
#
#  id         :integer          not null, primary key
#  province   :string(255)
#  city       :string(255)
#  school     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Student < ApplicationRecord
  include Identity
  include BeanFamily

  after_create_commit :create_welcome_message

  def format
    {
        id: self.id,
        province: self.province,
        city: self.city,
        school: self.school
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
