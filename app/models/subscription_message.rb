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

class SubscriptionMessage < Message

  def send_to_redis
    # teacher = self.user.identity
    # followed_by = teacher.followed_by
    # followed_by.each do |user|
    #   $redis.zadd("user::#{user.id}", 100, JSON(self.format_for_redis))
    # end
  end
end
