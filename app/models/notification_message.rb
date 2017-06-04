# == Schema Information
#
# Table name: messages
#
#  id            :integer          not null, primary key
#  content       :text(65535)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  channel       :string(255)
#  type          :string(255)
#  expired_at    :datetime
#  state         :integer
#  student_id    :integer
#  teacher_id    :integer
#  staff_id      :integer
#  university_id :integer
#  direction     :string(255)
#  img_url       :string(255)
#

class NotificationMessage < Message

  # after_create_commit :send_to_redis

  # private
  # def send_to_redis
  #   #to all student exist
  #   users  = User.where identity_type: 'Student'
  #   users.each do |user|
  #     $redis.zadd("user::#{user.id}", 100, JSON(self.format_for_redis))
  #   end
  # end
  #
  # def self.sync_all_to_student_redis(user)
  #   msgs = NotificationMessage.all.map { |msg| [100, JSON(msg.format_for_redis)] }
  #   $redis.zadd("user::#{user.id}",msgs)
  # end
  def format_for_redis
    {
        dsin: self.dsin,
        type: self.type,
        img_url: self.img_url,
        content: self.content,
        created_at: self.created_at,
        university: self.university.try(:format),
        direction: self.direction || 'down',
        attached_stories: self.attached_stories.map{|s| s.format},
        attached_photos: self.attached_photos.map{|p| p.format},
        attached_majors: self.attached_majors.map{|m| m.format},
        attached_tasks: self.attached_tasks.map{|t| t.format}
    }
  end

end
