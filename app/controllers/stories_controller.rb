class StoriesController < ApplicationController
  def show
  end

  def list
    stories = Story.all.map{|s| s.format}
    render json: {
        code: 0,
        data: stories
    }
  end


  def get_story
    story = Story.find_by id: params[:id]
    render json: {
        code: 0,
        data: story.format
    }
  end


  def create_story
    Story.create! title: params[:title],
                  description: params[:description],
                  content: params[:content],
                  user_id: params[:user_id]
    render json: {
        code: 0,
        message: 'created succ'
    }
  end
end
