# == Schema Information
#
# Table name: followings
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  followable_id   :integer
#  followable_type :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Following < ApplicationRecord
  belongs_to :user
  belongs_to :followable, :polymorphic => true



end
