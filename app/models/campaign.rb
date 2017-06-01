# == Schema Information
#
# Table name: campaigns
#
#  id            :integer          not null, primary key
#  university_id :integer
#  teacher_id    :integer
#  address       :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Campaign < ApplicationRecord

  includes BeanFamily
  belongs_to :university




end
