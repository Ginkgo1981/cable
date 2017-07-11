# == Schema Information
#
# Table name: resume_dic_industries
#
#  id         :uuid             not null, primary key
#  name       :string
#  q_uuid     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ResumeDicIndustry < ApplicationRecord
end
