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

class PhotoSerializer < ApplicationSerializer
  attributes :id, :dsin, :key, :img_url
end
