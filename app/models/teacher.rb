# == Schema Information
#
# Table name: teachers
#
#  id         :integer          not null, primary key
#  yxmc       :string(255)
#  yxdm       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Teacher < ApplicationRecord
  include Identity
  include BeanFamily
  def format
    {
        id:  self.id,
        yxmc: self.yxmc,
        yxdm: self.yxdm
    }
  end

end
