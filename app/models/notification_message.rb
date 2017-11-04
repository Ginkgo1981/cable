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
#  priority    :integer          default(0)
#

class NotificationMessage < Message

  def self.sink_all_to_redis
    $redis_cable.del('notification_messages_to_student_list')
    NotificationMessage.where(state: 1).order(:priority).each do |msg|
      msg.send_to_redis
    end
  end
  def send_to_redis
    # if self.receiver.is_a? Student
    $redis_cable.rpush 'notification_messages_to_student_list', JSON(self.format_for_redis)
    # end
  end
end
