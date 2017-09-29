# == Schema Information
#
# Table name: invitings
#
#  id         :uuid             not null, primary key
#  inviter_id :uuid
#  invitee_id :uuid
#  group_id   :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Inviting < ApplicationRecord

  belongs_to :inviter, class_name: User
  belongs_to :invitee, class_name: User
end
