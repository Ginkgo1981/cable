# == Schema Information
#
# Table name: messages
#
#  id          :uuid             not null, primary key
#  content     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  type        :string
#  expired_at  :datetime
#  state       :integer
#  img_url     :string
#  receiver_id :uuid
#  sender_id   :uuid
#

class NotificationMessage < Message

  def send_to_redis
    if self.direction == 'student'
      $redis.rpush 'notification_student', JSON(self.format_for_redis)
    else
      $redis.rpush 'notification_teacher', JSON(self.format_for_redis)
    end
  end
end
