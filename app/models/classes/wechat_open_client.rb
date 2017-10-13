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


  def self.generate_pay_sign sign_params, key = nil
    sign_params = Hash[sign_params.sort]
    sign_params = sign_params.merge({key: 'aaaaaa'})
    result_string = ''
    sign_params.each { |key, value|
      result_string += (key.to_s + '=' + value.to_s + '&')
    }
    Digest::MD5.hexdigest(result_string[0..-2]).upcase
  end
    amount = 100
    openid = 'oOle20eNMjgKtMMjU5HpxO8mM5mU'
    mch_id = '1490334232'
    mch_billno = mch_id + Time.now.strftime('%Y%m%d%H%M%S') + '%04d' % rand(10**4)
    timestamp = Time.now.to_i.to_s
    sign_params = {
        nonce_str: rand(10**24).to_s,
        mch_billno: mch_billno,
        mch_id: mch_id,
        wxappid: 'wx0020670ada444281',
        nick_name: '求职小冰',
        send_name: '求职小冰',
        re_openid: openid,
        total_amount: amount,
        min_value: amount,
        max_value: amount,
        total_num: 1,
        wishing: '求职小冰欢迎您',
        client_ip: '192.168.0.1',
        act_name: '求职小冰欢迎您',
        remark: '求职小冰欢迎您！',
    }
    data = sign_params.merge({sign: generate_pay_sign(sign_params)}) #, WepaySetting.gzh.partnerkey.to_s

    binding.pry
    conn = Faraday.new("https://api.mch.weixin.qq.com/mmpaymkttransfers/sendredpack",
                       :ssl => {:client_cert => OpenSSL::X509::Certificate.new(File.read('/home/deploy/cert/apiclient_cert.pem')),
                                :client_key => OpenSSL::PKey::RSA.new(File.read('/home/deploy/cert/apiclient_key.pem')),
                       }) do |f|
      f.adapter :httpclient
    end
    xml = Nokogiri::XML::Builder.new do |xml|
      xml.xml do
        data.each do |k, v|
          xml.send("#{k}", "#{v}")
        end
      end
    end

    response = conn.post do |req|
      req.body = xml.to_xml
    end

    doc = Nokogiri::XML response.body
    return_code = doc.xpath("/xml/return_code").text
    return return_code.to_s == "SUCCESS", doc.to_s #unless return_code.to_s == "SUCCESS"
  end

end
