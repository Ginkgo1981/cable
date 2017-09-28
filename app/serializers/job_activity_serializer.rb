# == Schema Information
#
# Table name: job_activities
#
#  id          :uuid             not null, primary key
#  user_job_id :uuid
#  note        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class JobActivitySerializer < ApplicationSerializer
  attributes :id
end
