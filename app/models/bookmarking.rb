# == Schema Information
#
# Table name: bookmarkings
#
#  id                :uuid             not null, primary key
#  user_id           :uuid
#  bookmarkable_id   :uuid
#  bookmarkable_type :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Bookmarking < ApplicationRecord

  belongs_to :user
  belongs_to :bookmarkable, :polymorphic => true

end
