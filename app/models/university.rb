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
#  logo       :string(255)
#  province   :string(255)
#  hot        :integer          default(0)
#

class University < ApplicationRecord
  include BeanFamily
  include Attachable
  include Followable

  has_many :majors
  has_many :teachers
  has_many :messages
  has_many :stories
  has_many :point_messages
  has_many :campaigns

  def format
    {
        id: self.id,
        dsin: self.dsin,
        name: self.name,
        logo: self.logo,
        resource_type: 'University'

    }

  end

end
