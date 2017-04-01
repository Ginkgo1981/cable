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

class Message < ApplicationRecord
  include Bookmarkable
  include BeanFamily

  scope :with_type, -> (type) {where(type: type)}
  belongs_to :user
  belongs_to :attachment, polymorphic: true, optional: true
  belongs_to :receiver, class_name: User, optional: true

  def format_for_redis
    {
        id: self.id,
        user_id: self.user_id,
        receiver_id: self.receiver_id,
        type: self.type,
        content: self.content,
        created_at: self.created_at,
        attachment_id: self.attachment_id,
        attachment_type: self.attachment_type
    }
  end
  # after_create_commit {MessageBroadcastJob.perform_now self}

end
