# == Schema Information
#
# Table name: staffs
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Staff < ApplicationRecord

  include Identity



end
