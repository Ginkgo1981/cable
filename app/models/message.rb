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
  belongs_to :user
  belongs_to :attachment, polymorphic: true, optional: true
  belongs_to :receiver, class_name: User, optional: true

  def format_for_redis
    {
        id: self.id,
        type: self.type,
        content: self.content
    }
  end
  # after_create_commit {MessageBroadcastJob.perform_now self}

end
