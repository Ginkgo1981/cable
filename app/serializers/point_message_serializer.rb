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

class PointMessageSerializer < ApplicationSerializer
  attributes :id, :dsin, :content
end
