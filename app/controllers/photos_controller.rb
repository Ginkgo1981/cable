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

  def save_photo_by_url
    url = params[:url] #|| 'http://r.xiumi.us/board/v5/3oTAV/61488759'
    web_driver = Selenium::WebDriver.for :remote, desired_capabilities: :phantomjs
    web_driver.navigate.to url
    sleep 3
    name = "story-#{Time.current.to_i}.jpg"
    file = web_driver.save_screenshot name
    bucket = 'gaokao'
    put_policy = Qiniu::Auth::PutPolicy.new(bucket)
    uptoken = Qiniu::Auth.generate_uptoken(put_policy)
    conn = Faraday.new('https://up.qbox.me') do |f|
      f.request :multipart
      f.request :url_encoded
      f.adapter :net_http
    end
    payload = { file: Faraday::UploadIO.new(file.path, 'image/jpeg'),
                token: uptoken,
                key: name.split(/\./)[0]
    }
    res = conn.post('/', payload)
    key = JSON(res.body)['key'].split(/\./)[0]
    photo = Photo.create! key: key
    render json: { code: 0, key: photo.key }
  end

end
