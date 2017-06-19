# == Schema Information
#
# Table name: major_hots
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  hot        :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MajorHot < ApplicationRecord

  include BeanFamily


end
