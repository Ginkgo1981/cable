# == Schema Information
#
# Table name: cities
#
#  id         :uuid             not null, primary key
#  name       :string
#  hot        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class City < ApplicationRecord
  include BeanFamily


end
