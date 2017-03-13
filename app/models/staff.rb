# == Schema Information
#
# Table name: staffs
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Staff < ApplicationRecord
  include Identity



end
