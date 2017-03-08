# == Schema Information
#
# Table name: students
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  province   :string(255)
#  city       :string(255)
#  school     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Student < ApplicationRecord

  include Identity



end
