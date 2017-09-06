# == Schema Information
#
# Table name: tags
#
#  id            :uuid             not null, primary key
#  taggable_id   :uuid
#  taggable_type :string
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  tagged_by     :uuid
#

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
    tags = taggable.tags.map { |tag| tag.format }
    render json: {
        code: 0,
        data: tags
    }
  end


  def libs
    tags = File.open("features/#{params[:category]}.txt").read.split(/\n/)
    render json: {code: 0, data: { tags: tags }}
  end


end
