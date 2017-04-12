# == Schema Information
#
# Table name: universities
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  code       :string(255)
#  city       :string(255)
#  address    :string(255)
#  website    :string(255)
#  tel        :string(255)
#  brief      :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class University < ApplicationRecord
  include BeanFamily
  include Attachable

  has_many :majors
  has_many :teachers

end
