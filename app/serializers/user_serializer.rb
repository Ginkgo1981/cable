class UserSerializer < ApplicationSerializer
  attributes :id, :cell, :name
  # belongs_to :identity, polymorphic: true, optional: true, if: -> {instance_options[:include_identity]}

end
