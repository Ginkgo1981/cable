# == Schema Information
#
# Table name: stories
#
#  id               :uuid             not null, primary key
#  title            :string
#  description      :string
#  content          :text
#  coverage_img_url :string
#  user_id          :uuid
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class StoriesController < ApplicationController

  before_action :find_user_by_token!, only: [:list, :update_story, :update_story, :create_story, :delete_story]
  # before_action :find_entity_by_dsin!

  def list
    # raise CableException::TypeError unless @entity.is_a? University
    # raise CableException::PermissionError unless check_permission! @user, @entity
    stories = Story.all
    render json: stories,
           meta: {code: 0},
           each_serializer: StorySerializer
  end


  def get_story
    story = Story.find_by id: params[:id]
    render json: {code: 0, data: story.format}
  end

  def update_story
    story = Story.find_by id: params[:id]
    story.update!(params[:story].permit(:title,:description, :content, :coverage_img_url, :user_id))
    render json: {code: 0, msg: 'succ'}
  end

  def create_story
    story = Story.create! params[:story].permit(:title,:description, :content, :coverage_img_url, :user_id)
    render json: {code: 0, msg: 'succ'}
  end


  def delete_story
    story = Story.find_by id: params[:id]
    story.destroy
    render json:{code: 0, msg: 'succ'}
  end

end
