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
  # include BeanFamily
  include Attachable

  belongs_to :student, optional: true
  # belongs_to :university, optional: true
  # belongs_to :teacher, optional: true

  # scope :filter_by_type, -> (type) {where(type: type)}
  # scope :filter_by_entity, -> (entity){ where("#{entity.class.name.downcase.to_s}": entity)}

  def format_for_redis
    if json = $redis.get("#{self.class.name.downcase}::#{self.id}")
      JSON.parse(json)
    else
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
      $redis.set("#{self.class.name.downcase}::#{self.id}", JSON(fommatted))
      fommatted
    end
  end
end
