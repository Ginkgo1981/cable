# == Schema Information
#
# Table name: messages
#
#  id              :integer          not null, primary key
#  content         :text(65535)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  channel         :string(255)
#  type            :string(255)
#  attachment_id   :integer
#  attachment_type :string(255)
#  expired_at      :datetime
#  state           :integer
#  student_id      :integer
#  teacher_id      :integer
#  staff_id        :integer
#  university_id   :integer
#  direction       :string(255)
#

class PointMessage < Message

  after_create_commit :send_to_redis

  private
  def send_to_redis
    $redis.zadd("user::#{self.receiver_id}", 100, JSON(self.format_for_redis))
  end





end
