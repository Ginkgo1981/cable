namespace :story do
  desc 'convert_url_to_jpg'
  task convert_url_to_jpg: :environment do
    url = 'http://r.xiumi.us/board/v5/3oTAV/61488759'
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
    puts "[story] convert_url_to_jpg succ, key: #{photo.key}"
  end
end
