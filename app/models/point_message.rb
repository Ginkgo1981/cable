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

class PointMessage < Message

  # after_create_commit :send_to_redis


  def self.set_one
    msg = PointMessage.create! receiver_id: 'eb97ff5e-552d-4c35-8304-62e50c8845d2',
                         content: '今日招聘信息'
    msg.send_to_redis
  end


  def self.reply(title, receiver_id) #直接返回,不放入redis
    msg = PointMessage.create! receiver_id: receiver_id,
                               content: "小主,我们为你找到了10条招聘信息匹配你的 #{title},请查收"
    #todo, need to refine
    # jobs = Job.search(title).records
    # msg.add_attachments jobs
    # msg.set_job_attachments jobs
    msg.format_for_redis
  end

  def self.university(university_name, receiver_id) #直接返回,不放入redis
    msg = PointMessage.create! receiver_id: receiver_id,
                               content: "#{university_name} - 招聘信息"
    jobs = Job.where(job_origin_web_site_name: university_name).limit(10)
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
    $redis_cable.zadd("user::#{self.receiver_id}", 100, JSON(self.format_for_redis))
  end

  def send_to_all_online_users
    json = JSON(self.format_for_redis)
    User.online.each do  |user|
      $redis_cable.zadd("user::#{user.id}", 100, json)
    end
  end

end
