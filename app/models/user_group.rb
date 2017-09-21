# == Schema Information
#
# Table name: user_groups
#
#  id         :uuid             not null, primary key
#  user_id    :uuid
#  group_id   :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserGroup < ApplicationRecord

  belongs_to :user
  belongs_to :group


end
