class UserSerializer < ApplicationSerializer
  attributes :dsin, :cell, :name, :nickname, :province, :city, :headimgurl
  # belongs_to :identity, polymorphic: true, optional: true, if: -> {instance_options[:include_identity]}

end
