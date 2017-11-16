require 'singleton'
class WechatMiniAppClient
  attr_reader :appid, :appsecret

  def initialize(appid, appsecret)
    # @appid = 'wx0f381a5501cad4a6'
    # @appsecret = 'c03ee61337e4273ae5c89c186e95517c'
    @appid = appid
    @appsecret = appsecret
  end

  def access_token
    token = $redis_cable.get("wechat_mini_app_access_token_#{@appid}")
    unless token
      url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{@appid}&secret=#{@appsecret}"
      res = Faraday.get(url)
      token = JSON(res.body)['access_token']
      $redis_cable.cache("wechat_mini_app_access_token_#{@appid}", token, 2 * 60 * 60)
    end
    token
  end

  def send_customer_message(json_str)
    # {
    #     "touser":"OPENID",
    #     "msgtype":"image",
    #     "image":
    #         {
    #             "media_id":"MEDIA_ID"
    #         }
    # }
    {"touser":"opvsg0VHguzEeOtL2hGtznCjmg0g","msgtype":"image","image":{"media_id":"Z3a7BFjDsWUZmt-Ww7OETu7sPMUOMgJjuj8IWF8HTVI0DeuZJwpVf1c23H3oEVah"}}

    # curl -F media=@098.jpg "https://api.weixin.qq.com/cgi-bin/media/upload?access_token=uPo6SZniYyUJ2cq-RZqkzMqiHL982fQtwoZsgDWBeEZa9L784VR6zr_L20GZeNexPMUg6rh-vHFjRRi9JfrvlP-SpjpP28QiQ6p3TIEMs7gQKFcAHAJDY&type=image"
    # msgtype [text,link,miniprogrampage, image]
    # "text":
    #     {
    #         "content":"Hello World"
    #     }

    # payload = {
    #
    #     image:
    #         {
    #             media_id:"59MulwFREhz7xPZxNSzmAuGxgX9RKKAdVmaJibYIIroKx5OMeGXz57XMg-7H7huu"
    #         }
    # }
    # binding.pry

    # "link": {
    #     "title": "Happy Day",
    #     "description": "Is Really A Happy Day",
    #     "url": "URL",
    #     "thumb_url": "THUMB_URL"
    # }


    # "miniprogrampage":{
    #     "title":"title",
    #     "pagepath":"pagepath",
    #     "thumb_media_id":"thumb_media_id"
    # }


    json = JSON(json_str).symbolize_keys
    openid = json[:openid]
    msgtype = json[:msgtype]
    json_data = { touser: openid, msgtype: msgtype }
    json_data.merge!(json[:payload])
    url = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=#{access_token}"
    Faraday.post url, JSON.generate(json_data)
  end



end
