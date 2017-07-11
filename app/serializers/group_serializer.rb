# == Schema Information
#
# Table name: groups
#
#  id           :uuid             not null, primary key
#  group_no     :string
#  init_user_id :uuid
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class GroupSerializer < ApplicationSerializer
  attributes :id
end
