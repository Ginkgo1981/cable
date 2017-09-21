# == Schema Information
#
# Table name: resume_dic_experiences
#
#  id            :uuid             not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  industry_id   :uuid
#  industry_name :string
#  name          :string
#  content       :string
#

class ResumeDicExperience < ApplicationRecord


  def format
    {
        name: self.name,
        content: self.content
    }
  end

end
