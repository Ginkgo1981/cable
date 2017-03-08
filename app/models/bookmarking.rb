# == Schema Information
#
# Table name: bookmarkings
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  bookmarkable_id   :integer
#  bookmarkable_type :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Bookmarking < ApplicationRecord

  belongs_to :user
  belongs_to :bookmarkable, :polymorphic => true

end
