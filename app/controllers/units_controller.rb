class UnitsController < ApplicationController

  def dsin
    dsin = params[:dsin]
    entity = Bean.find_by_dsin dsin
    render json: entity,
           serializer: "#{entity.class.to_s}Serializer".constantize,
           meta: {code: 0},
           include_user: true
  end

end
