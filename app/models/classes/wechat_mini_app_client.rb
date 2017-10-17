require 'singleton'
class WechatMiniAppClient
  attr_reader :appid, :appsecret

  def initialize()
    @appid = 'wx0f381a5501cad4a6'
    @appsecret = 'c03ee61337e4273ae5c89c186e95517c'
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

  def send_customer_message(openid, msgtype, payload)

    # msgtype [text,link,miniprogrampage, image]
    # "text":
    #     {
    #         "content":"Hello World"
    #     }

    # "image":
    #     {
    #         "media_id":"MEDIA_ID"
    #     }

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

    json_data = { touser: openid, msgtype: msgtype}.merge(payload)
    url = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=#{access_token}"
    Faraday.post url, JSON.generate(json_data)
  end



end
