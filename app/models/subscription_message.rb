# == Schema Information
#
# Table name: messages
#
#  id              :integer          not null, primary key
#  content         :text(65535)
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  channel         :string(255)
#  type            :string(255)
#  receiver_id     :integer
#  attachment_id   :integer
#  attachment_type :string(255)
#

class SubscriptionMessage < Message
  after_create_commit :send_to_redis

  private
  def send_to_redis
    teacher = self.user.identity
    followed_by = teacher.followed_by
    followed_by.each do |user|
      $redis.zadd("user::#{user.id}", 100, JSON(self.format_for_redis))
    end
  end
end
