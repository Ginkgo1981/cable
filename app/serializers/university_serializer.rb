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
#

class UniversitySerializer < ApplicationSerializer
  attributes :id, :name, :province, :city, :address, :website, :dsin, :logo
  has_many :majors , if: -> {instance_options[:include_majors]}

  has_many :stories , if: -> {instance_options[:include_stories]}

  attribute :brief,  if: -> {instance_options[:include_brief]}
  attribute :address,  if: -> {instance_options[:include_adress]}
  attribute :website,  if: -> {instance_options[:include_website]}
end
