# == Schema Information
#
# Table name: likings
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  likable_id   :integer
#  likable_type :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  comment      :string(255)
#

class Liking < ApplicationRecord

  belongs_to :user
  belongs_to :likable, :polymorphic => true, counter_cache: :count_of_like

  default_scope { order(created_at: :desc) }


  # def format
  #   {
  #       id: self.id,
  #       comment: self.comment,
  #       user: self.user.format_basic,
  #       created_at: self.created_at.strftime('%m月%d日 %H:%M')
  #   }
  # end

end
