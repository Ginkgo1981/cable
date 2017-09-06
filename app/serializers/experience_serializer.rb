# == Schema Information
#
# Table name: experiences
#
#  id         :uuid             not null, primary key
#  resume_id  :uuid
#  title      :string
#  content    :text
#  images     :text             is an Array
#  start_date :datetime
#  end_date   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ExperienceSerializer < ApplicationSerializer
  attributes :id, :resume_id, :title, :content, :images, :start_date, :end_date
end
