class UniversitySerializer < ApplicationSerializer
  attributes :id, :name, :province, :city, :address, :website, :dsin, :logo
  has_many :major , if: -> {instance_options[:include_major]}
  attribute :brief,  if: -> {instance_options[:include_brief]}
  attribute :address,  if: -> {instance_options[:include_adress]}
  attribute :website,  if: -> {instance_options[:include_website]}
end
