class LikingSerializer < ApplicationSerializer
  attributes :id,:comment
  attribute :created_at
  belongs_to :user
  def created_at
    object.created_at.strftime('%m月%d日 %H:%M')
  end

end
