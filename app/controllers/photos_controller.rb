# == Schema Information
#
# Table name: photos
#
#  id         :uuid             not null, primary key
#  name       :string
#  key        :string
#  img_url    :string
#  height     :integer
#  width      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PhotosController < ApplicationController


  def save_photo
    Photo.create key: params[:key]
    photos = Photo.all
    render json: photos,
           each_serializer: PhotoSerializer,
           meta: {code: 0}
  end

  def get_photos
    photos = Photo.all
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
