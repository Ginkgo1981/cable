class TagsController < ApplicationController

  def tag
    taggable = params[:taggable_type].constantize.find_by(:id => params[:taggable_id])
    taggable.tags.create tagged_by: params[:tagged_by],
                         name: name
    render json: {
        code: 0,
        message: 'succ'
    }
  end


  def tags
    taggable = params[:taggable_type].constantize.find_by(:id => params[:taggable_id])
    tags = taggable.tags.map { |tag| tag.format}
    render json: {
        code: 0,
        data: tags
    }
  end

  def tag_list


  end
end
