class UniversitySerializer < ApplicationSerializer
  attributes :id, :name, :city, :code, :address, :website, :dsin
  has_many :major , if: -> {instance_options[:include_major]}
  attribute :brief,  if: -> {instance_options[:include_brief]}
end
