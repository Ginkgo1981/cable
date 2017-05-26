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

class Message < ApplicationRecord
  include Bookmarkable
  include BeanFamily
  include Attachable

  belongs_to :student, optional: true
  belongs_to :university, optional: true
  belongs_to :teacher, optional: true
  # belongs_to :attachment, polymorphic: true, optional: true

  scope :filter_by_type, -> (type) {where(type: type)}
  scope :filter_by_entity, -> (entity){ where("#{entity.class.name.downcase.to_s}": entity)}

  # before_create :set_university
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
        attached_majors: self.attached_majors.map{|m| m.format}
    }
  end

  # after_create_commit {MessageBroadcastJob.perform_now self}

  # private
  # def set_university
  #   if self.teacher_id
  #     teacher = Teacher.find self.teacher_id
  #     self.university = teacher.university
  #   end
  # end

end
