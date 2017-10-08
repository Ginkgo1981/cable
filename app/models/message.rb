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

class Message < ApplicationRecord
  include Bookmarkable
  include Attachable
  belongs_to :sender, foreign_key: :sender_id ,class_name:  User, optional: true
  belongs_to :receiver, foreign_key: :receiver_id, class_name: User, optional: true

  def format_for_redis
    # if json = $redis_cable.get("#{self.class.name.downcase}::#{self.id}")
    #   JSON.parse(json)
    # else
      fommatted = {
          id: self.id,
          type: self.type,
          img_url: self.img_url,
          content: self.content,
          receiver: self.receiver.try(:format),
          sender: self.sender.try(:format) || {id: 0, name: '天马招聘团队'},
          created_at: self.created_at,
          attachments: self.attachments.map{|a| a.format.symbolize_keys.merge({type: a.class.name.downcase})}
      }
      # $redis_cable.set("#{self.class.name.downcase}::#{self.id}", JSON(fommatted))
      fommatted
  end


  def format
    {
        id: self.id,
        type: self.type,
        img_url: self.img_url,
        content: self.content,
        receiver: self.receiver.try(:format),
        sender: self.sender.try(:format) || {id: 0, name: '天马招聘团队'},
        created_at: self.created_at,
        attachments: self.attachments.map{|a| a.format.symbolize_keys.merge({type: a.class.name.downcase})}
    }
  end


end
