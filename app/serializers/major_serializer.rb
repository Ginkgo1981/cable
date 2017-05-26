class MajorSerializer < ApplicationSerializer
  attributes :id, :dsin, :code, :name, :content

  attribute :goal, if: -> {instance_options[:include_brief]}
  attribute :claim, if: -> {instance_options[:include_brief]}
  attribute :course, if: -> {instance_options[:include_brief]}
  belongs_to :university,  if: -> {instance_options[:include_university]}

end
