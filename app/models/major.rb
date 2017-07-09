# == Schema Information
#
# Table name: majors
#
#  id            :uuid             not null, primary key
#  name          :string
#  code          :string
#  university_id :uuid
#  goal          :string
#  claim         :string
#  course        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Major < ApplicationRecord



end
