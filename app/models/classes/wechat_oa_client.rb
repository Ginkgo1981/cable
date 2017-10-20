require 'singleton'
class WechatOaClient
  attr_reader :appid, :appsecret

  def initialize()
    @appid = Rails.application.config_for('wechat_oa')['AppID']
    @appsecret = Rails.application.config_for('wechat_oa')['AppSecret']
  end

  def auth(oauth_code)
    url = 'https://api.weixin.qq.com/sns/oauth2/access_token'
    json_data = {
        appid:  @appid,
        secret: @appsecret,
        code: oauth_code,
        grant_type: 'authorization_code'
    }
    resp = Faraday.post url, json_data
    JSON(resp.body)['openid']
  end

  def access_token
    token = $redis.get("wechat_access_token_#{@appid}")
    unless token
      url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{@appid}&secret=#{@appsecret}"
      res = Faraday.get(url)
      token = JSON(res.body)['access_token']
      $redis.cache("wechat_access_token_#{@appid}", token, 2 * 60 * 60)
    end
    token
  end

  def get_user_info(access_token, openid)

    url = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=#{access_token}&openid=#{openid}&lang=zh_CN"
    res = Faraday.get(url)

    json = JSON(res.body)
    puts json
    json
  end



  def send_template_message(json_data)
    url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=#{access_token}"
    Faraday.post url, json_data.to_json
  end

  def send_customer_message(payload)
    json_data = { touser: payload[:openid].to_s, msgtype: 'news', news: {articles: [payload[:article]]}}
    url = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=#{access_token}"
    Faraday.post url, JSON.generate(json_data)
  end
end