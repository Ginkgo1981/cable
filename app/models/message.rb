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

class Message < ApplicationRecord
  include Bookmarkable
  include BeanFamily
  include Attachable

  belongs_to :student, optional: true
  belongs_to :university, optional: true
  belongs_to :teacher, optional: true

  # scope :filter_by_type, -> (type) {where(type: type)}
  # scope :filter_by_entity, -> (entity){ where("#{entity.class.name.downcase.to_s}": entity)}

  def format_for_redis
    if json = $redis.get(self.dsin)
      JSON.parse(json)
    else
      fommatted = {
          # resource_type: 'Message',
          dsin: self.dsin,
          resource_type: self.type,
          img_url: self.img_url,
          content: self.content,
          created_at: self.created_at,
          university: (self.university || University.last).try(:format),
          student: self.student.try(:format),
          direction: self.direction || 'student',
          attached_stories: self.attached_stories.map{|s| s.format},
          attached_photos: self.attached_photos.map{|p| p.format},
          attached_majors: self.attached_majors.map{|m| m.format},
          attached_tasks: self.attached_tasks.map{|t| t.format},
          attached_students: self.attached_students.map{|s| s.format}
      }
      $redis.set(self.dsin, JSON(fommatted))
      fommatted
    end
  end
end
