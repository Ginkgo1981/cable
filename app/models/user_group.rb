# == Schema Information
#
# Table name: user_groups
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  group_id   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserGroup < ApplicationRecord

  belongs_to :user
  belongs_to :group
end
