# == Schema Information
#
# Table name: resumes
#
#  id            :uuid             not null, primary key
#  job_intention :string
#  job_cities    :string
#  job_kind      :string
#  job_title     :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  university    :string
#  major         :string
#  user_id       :uuid
#

class ResumeSerializer < ApplicationSerializer
  attributes :id, :user_id, :job_intention, :job_cities, :job_kind, :job_title, :score

  has_many :educations
  has_many :experiences
  has_many :skills
  has_many :honors


  def job_cities
    object.job_cities
  end
  def score
    object.score
  end

end