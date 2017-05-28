class DsinsController < ApplicationController

  before_action :find_entity_by_dsin!, except: [:get_upload_token]

  def show
    render json: @entity,
           serializer: "#{@entity.class.to_s}Serializer".constantize,
           meta: {code: 0},
           include_user: true,
           include_tags: true,
           include_stories: !!params[:include_stories], #UniversitySerializer
           include_majors: !! params[:include_majors] #UniversitySerializer
  end

  def update
    res = @entity.update!(params[:entity].except(:dsin, :id, '$$index').permit!.to_h)
    render json: {meta: {code: 0, message: 'succ'}}
  end

  def delete
    res = @entity.destroy
    render json: {meta: {code: 0, message: 'succ'}}
  end


  def tag
    tag = @entity.tags.create tagged_by: params[:tagged_by],
                              name: params[:name]
    render json: tag,
           meta: {code: 0},
           serializer: TagSerializer
  end

  # def tags
  #   tags = @entity.tags.preload(:bean)
  #   render json: tags,
  #       meta: {code: 0},
  #       each_serializer: TagSerializer
  # end


  def save_photo
    key = params[:key]
    @entity.attached_photos.create key: params[:key]
    photos = @entity.attached_photos.preload(:bean)
    render json: photos,
           each_serializer: PhotoSerializer,
           meta: {code: 0}
  end

  def get_photos
    photos = @entity.attached_photos.preload(:bean)
    render json: photos,
           each_serializer: PhotoSerializer,
           meta: {code: 0}
  end


  def get_upload_token
    bucket = 'gaokao'
    put_policy = Qiniu::Auth::PutPolicy.new(bucket)
    uptoken = Qiniu::Auth.generate_uptoken(put_policy)
    render json: {
        code: 0,
        uptoken: uptoken
    }
  end

end
