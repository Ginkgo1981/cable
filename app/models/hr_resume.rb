# == Schema Information
#
# Table name: hr_resumes
#
#  id         :uuid             not null, primary key
#  hr_id      :uuid
#  resume_id  :uuid
#  state      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class HrResume < ApplicationRecord

  belongs_to :human_resource, foreign_key: :hr_id
  belongs_to :resume
end
