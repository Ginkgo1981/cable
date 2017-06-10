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
  belongs_to :university, optional: true
  # has_many :messages
  has_many :campaigns
  has_many :skycodes
  delegate :nickname, to: :user, allow_nil: true

  has_many :point_messages

  has_many :followings, as: :follower
  has_many :following_students, -> { uniq }, :through => :followings,  :source => :followable, :source_type => :Student


  has_many :followed_by, as: :followable, class_name: :Following
  has_many :followed_students, :through => :followed_by,  :source => :follower, :source_type => :Student


  def format
    {
        id: self.id,
        dsin: self.dsin,
        cell: self.cell,
        name: self.name,
        duty: self.duty,
        status: self.status,
        university: self.university.try(:format)
    }
  end

end
