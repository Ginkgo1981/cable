# == Schema Information
#
# Table name: resume_dic_honor_tips
#
#  id         :uuid             not null, primary key
#  name       :string
#  tips       :text             is an Array
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ResumeDicHonorTip < ApplicationRecord
end
