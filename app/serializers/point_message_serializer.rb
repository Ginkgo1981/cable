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

class PointMessageSerializer < ApplicationSerializer
  attributes :id, :dsin, :content
end
