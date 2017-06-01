# == Schema Information
#
# Table name: skycodes
#
#  id            :integer          not null, primary key
#  campaign_id   :integer
#  university_id :integer
#  teacher_id    :integer
#  address       :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Skycode < ApplicationRecord
  includes BeanFamily
  belongs_to :university
  belongs_to :campaign
  belongs_to :teacher


end
