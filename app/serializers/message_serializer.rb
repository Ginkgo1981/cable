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

class MessageSerializer < ApplicationSerializer
  attributes :id, :dsin, :content, :created_at, :type, :student_id, :teacher_id, :university_id
  belongs_to :student
  belongs_to :university
  belongs_to :teacher

  # attribute :student
  # def student
  #   {
  #       name: object.student.name,
  #       nickname: object.student.nickname,
  #       dsin: object.student.dsin
  #   }
  # end



end
