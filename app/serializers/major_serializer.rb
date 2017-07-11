# == Schema Information
#
# Table name: majors
#
#  id            :uuid             not null, primary key
#  name          :string
#  code          :string
#  university_id :uuid
#  goal          :string
#  claim         :string
#  course        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class MajorSerializer < ApplicationSerializer
  attributes :id, :dsin, :code, :name, :content

  attribute :goal, if: -> {instance_options[:include_brief]}
  attribute :claim, if: -> {instance_options[:include_brief]}
  attribute :course, if: -> {instance_options[:include_brief]}
  belongs_to :university,  if: -> {instance_options[:include_university]}

end
