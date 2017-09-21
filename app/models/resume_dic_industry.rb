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
  has_many :resume_dic_experiences, foreign_key: :industry_id

  def format
    {
        name: self.name,
        list: self.resume_dic_experiences.map(&:format)
    }
  end
end
