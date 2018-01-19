require 'singleton'
require 'digest/sha1'

class WechatOaClient
  attr_reader :appid, :appsecret

  TEMPLATE = 'jsapi_ticket=%{jsapi_ticket}&noncestr=%{nonce_str}&timestamp=%{timestamp}&url=%{url}'.freeze


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
    token = $redis.get("wechat_oa_access_token_#{@appid}")
    unless token
      url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{@appid}&secret=#{@appsecret}"
      res = Faraday.get(url)
      puts "==== access_token === "
      puts res.body
      token = JSON(res.body)['access_token']
      $redis.cache("wechat_oa_access_token_#{@appid}", token, 2 * 60 * 60)
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

  def get_js_ticket
    url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=#{self.access_token}&type=jsapi"
    res = Faraday.get(url)
    js_ticket = JSON(res.body)['ticket']
    puts js_ticket
    js_ticket
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


  def get_js_signature(url)
    timestamp = Time.now.to_i
    nonce_str = 'abcsssss'
    str = TEMPLATE % {
        jsapi_ticket: self.get_js_ticket,
        nonce_str: nonce_str,
        timestamp: timestamp,
        url: url
    }
    signature = Digest::SHA1.hexdigest(str)
    json =
      {
          signature: signature,
          nonce_str: nonce_str,
          timestamp: timestamp,
          url: url
      }
    puts "====== sign ======"
    puts json
    json
  end


end