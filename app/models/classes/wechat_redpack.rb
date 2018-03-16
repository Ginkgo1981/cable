require 'singleton'
class WechatRedpack
  def self.generate_pay_sign sign_params, key
    sign_params = Hash[sign_params.sort]
    sign_params = sign_params.merge({key: key})
    result_string = ''
    sign_params.each { |key, value|
      result_string += (key.to_s + '=' + value.to_s + '&')
    }
    Digest::MD5.hexdigest(result_string[0..-2]).upcase
  end

  #发送红包amount(单位：分)给user_id或openid
  def self.send_redpack amount, openid
    setting = Rails.application.config_for('wechat_redpack').symbolize_keys!
    # amount = 10
    # openid = 'oOle20eNMjgKtMMjU5HpxO8mM5mU'
    mch_id = setting[:mch_id]
    mch_billno = mch_id + Time.now.strftime('%Y%m%d%H%M%S') + '%04d' % rand(10**4)
    sign_params = {
        nonce_str: rand(10**24).to_s,
        mch_billno: mch_billno,
        mch_id: mch_id,
        wxappid: setting[:wxappid],
        nick_name: '大四小冰',
        send_name: '大四小冰',
        re_openid: openid,
        total_amount: amount,
        min_value: amount,
        max_value: amount,
        total_num: 1,
        wishing: '大四小冰欢迎您',
        client_ip: '192.168.0.1',
        act_name: '大四小冰欢迎您',
        remark: '大四小冰欢迎您！',
    }
    data = sign_params.merge({sign: generate_pay_sign(sign_params, setting[:partnerkey])})
    conn = Faraday.new('https://api.mch.weixin.qq.com/mmpaymkttransfers/sendredpack',
                       :ssl => {:client_cert => OpenSSL::X509::Certificate.new(File.read(setting[:client_cert])),
                                :client_key => OpenSSL::PKey::RSA.new(File.read(setting[:client_key])),
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


  def self.pay_wechat amount, openid  # 企业付款
    binding.pry
    setting = Rails.application.config_for('wechat_redpack').symbolize_keys!
    # amount = 10
    # openid = 'oOle20eNMjgKtMMjU5HpxO8mM5mU'
    mch_id = setting[:mch_id]
    mch_billno = mch_id + Time.now.strftime('%Y%m%d%H%M%S') + '%04d' % rand(10**4)
    sign_params = {
        mch_appid: setting[:wxappid],
        mchid: mch_id,
        nonce_str: rand(10**24).to_s,
        partner_trade_no: mch_billno,
        openid: openid,
        check_name: 'NO_CHECK',
        amount: amount,
        desc: '答题奖金',
        spbill_create_ip: '192.168.0.1'
    }
    data = sign_params.merge({sign: generate_pay_sign(sign_params, setting[:partnerkey])})
    conn = Faraday.new('https://api.mch.weixin.qq.com/mmpaymkttransfers/promotion/transfers',
                       :ssl => {:client_cert => OpenSSL::X509::Certificate.new(File.read(setting[:client_cert])),
                                :client_key => OpenSSL::PKey::RSA.new(File.read(setting[:client_key])),
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