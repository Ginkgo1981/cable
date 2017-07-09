# == Schema Information
#
# Table name: messages
#
#  id         :uuid             not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  type       :string
#  expired_at :datetime
#  state      :integer
#  student_id :uuid
#  staff_id   :uuid
#  direction  :string
#  img_url    :string
#

class PointMessage < Message

  # after_create_commit :send_to_redis

  def send_to_redis

    if self.direction == 'teacher'
      if self.teacher
        $redis.zadd("user::#{self.teacher.user.id}", 100, JSON(self.format_for_redis))
      else
        pp '哈哈,没人理你'
      end
    else
      $redis.zadd("user::#{self.student.user.id}", 100, JSON(self.format_for_redis))
    end
  end

end
