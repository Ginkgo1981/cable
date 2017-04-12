# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  key        :string(255)
#  img_url    :string(255)
#  height     :integer
#  width      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Photo < ApplicationRecord
  include BeanFamily

  has_one :Attaching,  as: :attachment, dependent: :destroy




end
