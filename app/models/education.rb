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

class Education < ApplicationRecord
  belongs_to :resume
  default_scope -> {order(created_at: :desc)}

  def format
    start_date = self.start_date.strftime('%Y-%m-%d') rescue nil
    end_date = self.end_date.strftime('%Y-%m-%d') rescue nil
    {
        id: self.id,
        university: self.university,
        major:  self.major,
        degree: self.degree,
        courses: self.courses,
        images: self.images,
        start_date: start_date,
        end_date: end_date
    }
  end



end
