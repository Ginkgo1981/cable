# == Schema Information
#
# Table name: skycode_students
#
#  id         :integer          not null, primary key
#  skycode_id :integer
#  student_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SkycodeStudent < ApplicationRecord
end
