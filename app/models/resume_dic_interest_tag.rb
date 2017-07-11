# == Schema Information
#
# Table name: resume_dic_interest_tags
#
#  id         :uuid             not null, primary key
#  intent     :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ResumeDicInterestTag < ApplicationRecord
end
