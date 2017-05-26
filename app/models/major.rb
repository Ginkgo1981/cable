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
#  content       :text(65535)
#

class Major < ApplicationRecord
  include BeanFamily
  belongs_to :university

  def format
    {
        id: self.id,
        name: self.name,
        dsin: self.dsin,
        content: self.content
    }
  end


end
