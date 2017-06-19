class WishcardSerializer < ApplicationSerializer
  attributes :dsin, :nickname, :headimgurl, :cities, :universities, :majors, :introdution, :count_of_like
  attribute :groups
  has_one :user
  # has_many :likings

  # def likings
  #   object.likings
  # end

  def groups
    object.following_groups.map(&:group_id)
  end

end
