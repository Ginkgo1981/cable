# == Schema Information
#
# Table name: user_jobs
#
#  id         :uuid             not null, primary key
#  user_id    :uuid
#  resume_id  :uuid
#  job_id     :uuid
#  company_id :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserJobSerializer < ApplicationSerializer
  attributes :id, :created_at

  belongs_to :user
  belongs_to :resume
  belongs_to :job
  belongs_to :company


  def created_at
    object.created_at.strftime('%m月%d日')
  end

end