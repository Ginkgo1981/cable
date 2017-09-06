# == Schema Information
#
# Table name: educations
#
#  id         :uuid             not null, primary key
#  resume_id  :uuid
#  university :string
#  major      :string
#  degree     :string
#  courses    :text             is an Array
#  images     :text             is an Array
#  start_date :datetime
#  end_date   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EducationSerializer < ApplicationSerializer
  attributes :id, :resume_id, :university, :major, :degree, :courses, :images, :start_date, :end_date
end
