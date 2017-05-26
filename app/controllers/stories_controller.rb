class StoriesController < ApplicationController

  before_action :find_user_by_token!
  before_action :find_entity_by_dsin!

  def list
    raise CableException::TypeError unless @entity.is_a? University
    raise CableException::PermissionError unless check_permission! @user, @entity
    stories = @entity.stories
    render json: stories,
           meta: {code: 0},
           each_serializer: StorySerializer
  end

  def create_story
    story = @university.stories.create! title: params[:title],
                                        teacher: @teacher,
                                        description: params[:description],
                                        content: params[:content],
                                        coverage_img_url: params[:coverage_img_url]

    render json: {code: 0, story: story}
  end

end