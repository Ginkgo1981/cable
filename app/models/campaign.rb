# == Schema Information
#
# Table name: campaigns
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  university_id :integer
#  teacher_id    :integer
#  note          :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Campaign < ApplicationRecord

  include BeanFamily
  include Followable
  belongs_to :university
  has_many :skycodes




end
