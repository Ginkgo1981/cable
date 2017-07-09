# == Schema Information
#
# Table name: staffs
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Staff < ApplicationRecord
  include Identity



end
