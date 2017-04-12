require 'singleton'
class WechatOpenClient
  attr_reader :appid, :appsecret

  def initialize()
    @appid =  Rails.application.config_for('wechat_open')['AppID']
    @appsecret = Rails.application.config_for('wechat_open')['AppSecret']
  end

  def get_access_token(code)
    url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{@appid}&secret=#{@appsecret}&code=#{code}&grant_type=authorization_code"
    res = Faraday.get(url)
    json = JSON(res.body)
    return json['access_token'], json['openid']
  end

  def get_user_info(access_token, openid)
    url = "https://api.weixin.qq.com/sns/userinfo?access_token=#{access_token}&openid=#{openid}"
    res = Faraday.get(url)
    JSON(res.body)
  end

end
