# == Schema Information
#
# Table name: likings
#
#  id           :uuid             not null, primary key
#  user_id      :uuid
#  likable_id   :uuid
#  likable_type :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  comment      :string
#

class LikingSerializer < ApplicationSerializer
  attributes :id,:comment
  attribute :created_at
  belongs_to :user
  def created_at
    object.created_at.strftime('%m月%d日 %H:%M')
  end

end
