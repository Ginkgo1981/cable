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

class Message < ApplicationRecord
  include Bookmarkable
  include BeanFamily

  belongs_to :student, optional: true
  belongs_to :university, optional: true
  belongs_to :teacher, optional: true
  belongs_to :attachment, polymorphic: true, optional: true

  scope :filter_by_type, -> (type) {where(type: type)}
  scope :filter_by_entity, -> (entity){ where("#{entity.class.name.downcase.to_s}": entity)}

  def format_for_redis
    {
        id: self.id,
        student_id: self.student_id,
        teacher_id: self.teacher_id,
        university_id: self.university_id,
        type: self.type,
        content: self.content,
        created_at: self.created_at,
        attachment_id: self.attachment_id,
        attachment_type: self.attachment_type
    }
  end

  #todo 20170423
  # after_create_commit {MessageBroadcastJob.perform_now self}

end
