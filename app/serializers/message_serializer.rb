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

class MessageSerializer < ApplicationSerializer
  attributes :id, :content, :created_at, :type, :expired_at, :priority, :receiver_id, :sender_id, :state
  # belongs_to :student
  # belongs_to :university
  # belongs_to :teacher

  # attribute :student
  # def student
  #   {
  #       name: object.student.name,
  #       nickname: object.student.nickname,
  #       dsin: object.student.dsin
  #   }
  # end



end
