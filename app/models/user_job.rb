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

class UserJob < ApplicationRecord

  belongs_to :user
  belongs_to :resume
  belongs_to :job
  belongs_to :company

  has_many :job_activities
  has_many :job_interviews
  has_one :job_offer

  after_create :deliver_by_email!

  def deliver_by_email!
    if self.company.company_email
      # HrMailer.new.welcome_email(self.company.company_email, self.resume.format_for_email).deliver!
    end
  end

  def deliver_by_phone!
    #todo
  end

end
