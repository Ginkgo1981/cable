# == Schema Information
#
# Table name: majors
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  code          :string(255)
#  university_id :integer
#  goal          :string(255)
#  claim         :string(255)
#  course        :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Major < ApplicationRecord
  belongs_to :university


  def format_brief
    {
        id: self.id,
        name: self.name,
        code: self.code,
    }
  end


  def format_detail
    {
        id: self.id,
        name: self.name,
        code: self.code,
        goal: self.goal,
        claim: self.claim,
        course: self.course
    }
  end

end
