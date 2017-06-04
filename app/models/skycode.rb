# == Schema Information
#
# Table name: skycodes
#
#  id            :integer          not null, primary key
#  campaign_id   :integer
#  university_id :integer
#  teacher_id    :integer
#  name          :string(255)
#  note          :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Skycode < ApplicationRecord
  include BeanFamily
  include Followable
  belongs_to :university, optional: true
  belongs_to :campaign,  optional: true
  belongs_to :teacher, optional: true



  def using?
    self.teacher_id || self.university_id
  end


end
