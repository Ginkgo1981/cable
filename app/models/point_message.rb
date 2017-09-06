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

class PointMessage < Message

  # after_create_commit :send_to_redis

  belongs_to :sender, foreign_key: :sender_id ,class_name:  User, optional: true
  belongs_to :receiver, foreign_key: :receiver_id, class_name: User, optional: true

  def self.set_one
    msg = PointMessage.create! receiver_id: 'eb97ff5e-552d-4c35-8304-62e50c8845d2',
                         content: '今日招聘信息'
    msg.send_to_redis
  end


  def self.reply(title, receiver_id) #直接返回,不放入redis
    msg = PointMessage.create! receiver_id: receiver_id,
                               content: "#{title} - 招聘信息"
    #todo, need to refine
    jobs = Job.search(title).records
    # msg.add_attachments jobs
    msg.set_job_attachments jobs
    msg.format_for_redis
  end

  def send_to_redis

    # if self.direction == 'teacher'
    #   if self.teacher
    #     $redis.zadd("user::#{self.teacher.user.id}", 100, JSON(self.format_for_redis))
    #   else
    #     pp '哈哈,没人理你'
    #   end
    # else
    # end
    $redis.zadd("user::#{self.receiver_id}", 100, JSON(self.format_for_redis))
  end

end
