# == Schema Information
#
# Table name: universities
#
#  id         :uuid             not null, primary key
#  name       :string
#  code       :string
#  city       :string
#  address    :string
#  website    :string
#  tel        :string
#  brief      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  logo       :string
#  province   :string
#  hot        :integer          default(0)
#  latitude   :float
#  longitude  :float
#

class University < ApplicationRecord
  acts_as_mappable default_units: :miles,
                   default_formula: :sphere,
                   distance_field_name: :distance,
                   lat_column_name: :latitude,
                   lng_column_name: :longitude



  # def self.nearest(origin)
  #
  #   lat_log = Geokit::LatLng.new origin[0], origin[1]
  #
  #
  # end
  # include BeanFamily
  # include Attachable
  # include Followable
  # has_many :majors
  # has_many :teachers
  # has_many :messages
  # has_many :stories
  # has_many :point_messages
  # has_many :campaigns

  # def format
  #   {
  #       id: self.id,
  #       dsin: self.dsin,
  #       name: self.name,
  #       logo: self.logo,
  #       resource_type: 'University'
  #
  #   }
  #
  # end

end
