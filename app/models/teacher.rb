# == Schema Information
#
# Table name: teachers
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  university_id :integer
#  cell          :string(255)
#  name          :string(255)
#  duty          :string(255)
#  status        :integer
#

class Teacher < ApplicationRecord
  include Identity
  include BeanFamily
  include Followable

  belongs_to :university, optional: true
  has_many :campaigns
  has_many :skycodes
  delegate :nickname, to: :user, allow_nil: true
  has_many :point_messages
  has_many :notification_messages


  def format
    {
        id: self.id,
        dsin: self.dsin,
        cell: self.cell,
        name: self.name,
        duty: self.duty,
        status: self.status,
        university: self.university.try(:format),
        resource_type: 'Teacher'
    }
  end

end
