class UserSerializer < ApplicationSerializer
  attributes :id, :cell, :name, :nickname, :province, :city, :headimgurl
  # belongs_to :identity, polymorphic: true, optional: true, if: -> {instance_options[:include_identity]}

end
