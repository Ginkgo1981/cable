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
  belongs_to :university
  has_many :messages




end
