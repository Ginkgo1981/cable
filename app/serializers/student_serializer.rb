class StudentSerializer < ApplicationSerializer
  attributes :id, :province, :city, :school, :dsin
  has_one :user , if: -> {instance_options[:include_user]}
  has_many :tags
  attribute :sat_score
  attribute :sat_province
  # attribute :user,  if: -> {instance_options[:include_user]}
  # attributes :user,only: [:id, :token]

  # def user
  #   object.user&.format
  # end

end