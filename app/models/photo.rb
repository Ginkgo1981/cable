# == Schema Information
#
# Table name: photos
#
#  id         :uuid             not null, primary key
#  name       :string
#  key        :string
#  img_url    :string
#  height     :integer
#  width      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Photo < ApplicationRecord
  include BeanFamily

  has_one :Attaching,  as: :attachment, dependent: :destroy


  def format
    {
        dsin:self.dsin,
        id: self.id,
        name: self.name,
        key: self.key,
        resource_type: 'Photo'
    }
  end


end
