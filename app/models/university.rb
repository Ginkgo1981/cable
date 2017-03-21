# == Schema Information
#
# Table name: universities
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  code       :string(255)
#  city       :string(255)
#  address    :string(255)
#  website    :string(255)
#  tel        :string(255)
#  brief      :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class University < ApplicationRecord

  has_many :majors


  def format_brief
    {
        id: self.id,
        name: self.name,
        city: self.city,
        code: self.code,
        address: self.address,
        website: self.website,
        tel: self.tel
    }
  end


  def format_detail
    {
        id: self.id,
        name: self.name,
        code: self.code,
        city: self.city,
        address: self.address,
        website: self.website,
        tel: self.tel,
        brief: self.brief,
    majors: self.majors.map{|m| m.format_brief}
    }
  end



end
