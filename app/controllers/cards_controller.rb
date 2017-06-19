class CardsController < ApplicationController



  def wishcards
    group = Group.find_by group_id: params[:group_id]
    raise CableException::NotFoundGroup unless group
    cards = group.followed_by_wishcards.order('count_of_like desc')
    render json: cards,
           each_serializer: WishcardSerializer,
           meta: {code: 0}
  end




end
