class HumanResourceSerializer < ApplicationSerializer
  attributes :id, :cell, :province, :headimgurl, :hr_approved

  has_one :human_resource_info
end
