# == Schema Information
#
# Table name: groups
#
#  id           :integer          not null, primary key
#  group_id     :string(255)
#  init_user_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Group < ApplicationRecord

  include Followable

  has_many :user_groups
  has_many :users, through: :user_groups


  def wishcard_trend
    {
        group_id: self.group_id,
        followed_by_wishcards: self.followed_by_wishcards.preload(:user, :bean).order('wishcards.count_of_like desc').map(&:format)

    }
  end



end
