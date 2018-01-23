class WechatsController < ApplicationController

  #receive WeChat notification
  def echo
    doc = Nokogiri::XML request.body.read
    openid = doc.css('FromUserName').text
    event = doc.css('Event').text
    wechat_oa_client = WechatOaClient.new()
    access_token = wechat_oa_client.access_token
    user_info = wechat_oa_client.get_user_info(access_token, openid).symbolize_keys
    puts user_info

    event_key = doc.css('EventKey').text

    #红包发放的逻辑
    #todo user is nil
    # user = User.find_by union_id: user_info[:unionid]
    # if user
    #   user.mp_openid = openid
    #   user.save
    #   if event == 'subscribe'
    #     if user.red_packs.size == 0
    #       amount = (100..110).to_a.sample
    #       user.red_packs.create! amount: amount, event: 'subscribe'
    #       SlackSendJob.perform_later("[cable] send-redpack #{user.nickname} #{amount}")
    #       WechatRedpack.send_redpack amount, openid
    #     end
    #   end
    # end

    if event == 'subscribe'
      user = User.find_by union_id: user_info[:unionid]
      if user
        user.mp_openid = openid
        user.save!
        puts '==== update mp_openid ===='
      else
        user = User.create! mp_openid: openid,
                            nickname: info[:nickName],
                            sex: info[:sex],
                            language: info[:language],
                            city: info[:city],
                            province: info[:province],
                            headimgurl: info[:headimgurl],
                            union_id: info[:unionid],
                            type: 'Reader'
        puts '====== create new user ========'
      end

      content =
<<EOM
hi~欢迎潜入百草英语阅读计划
小阅读 · 大世界 · 体验甜苦人生

百草英语阅读计划  尝鲜期
阅读书目：英语原版书《小王子》
现已上线~限量开放报名中~
↓↓↓
戳此链接，立即体验：https://images.gaokao2017.cn/follow.jpg

期待与你一起开启一场悦读之旅~
EOM
      payload =
          {
              "touser": openid,
              "msgtype": 'text',
              "text":
                  {
                      "content": content
                  }
          }

      wechat_oa_client.send_customer_message(payload)

    else

      if event_key == 'promotion'
        payload =
        {
            "touser": openid,
            "msgtype":'image',
            "image":
                {
                    "media_id":'hxrynkVuPClWdUKnfEiZHnvZXDFWruI7F4HhNVbRlrU'
                }
        }
        wechat_oa_client.send_customer_message(payload)
      end

    end

    render plain: 'success' #params[:echostr]
  end


  def get_js_signature
    url = params[:url]
    client = WechatOaClient.new
    signature = client.get_js_signature(url)
    render json: {code: 0, signature: signature}
  end

  def mini_app_customer_service

    # {:ToUserName=>"gh_d3c70c9c17bf", :FromUserName=>"opvsg0VHguzEeOtL2hGtznCjmg0g",
    # :CreateTime=>1508514634, :MsgType=>"event", :Event=>"user_enter_tempsession",
    # :SessionFrom=>"weapp"}
    json = JSON(request.body.read).symbolize_keys
    puts json
    openid = json[:FromUserName]
    user = User.find_by miniapp_openid: openid

    puts "======= mp_openid: #{user.mp_openid} ========="

    feedback = {}

    if json[:Content] && json[:Content].include?('就业津贴')
      feedback = {
          openid: openid,
          msgtype: 'image',
          payload: {
              image:
                  {
                      media_id: 'F4lOY2nJiW4vUGWiC0quXoaDiKdNOoEEbao_-S8Kl6vhpPLL1q4WGucXXUFirI-z'
                  }
          }
      }
    elsif json[:Content] && json[:Content].include?('找工作')
      term = json[:Content].split(/找工作/)[1].try(:strip)
      if term
        feedback = {
            openid: openid,
            msgtype: 'miniprogrampage',
            payload: {
                miniprogrampage: {
                    title: "招聘信息 - #{term}",
                    pagepath: "pages/job-list-page/job-list-page?jobs_key=#{term}",
                    thumb_media_id: 'F4lOY2nJiW4vUGWiC0quXoaDiKdNOoEEbao_-S8Kl6vhpPLL1q4WGucXXUFirI-z'
                }
            }
        }
        PointMessage.find_jobs(user.id, term)
      end

    elsif user.mp_openid.nil? && user.customer_service_activities.size == 0
      feedback = {
          openid: openid,
          msgtype: 'text',
          payload: {
              text:
                  {
                      content: '回复就业津贴,可得微信现金红包'
                  }
          }
      }
    else
      feedback = {
          openid: openid,
          msgtype: 'text',
          payload: {
              text:
                  {
                      content: '你可以这样问我 找工作 南京 化学工程'
                  }
          }
      }
    end
    wechat_mini_app_client = WechatMiniAppClient.new('wx0f381a5501cad4a6', 'c03ee61337e4273ae5c89c186e95517c')
    wechat_mini_app_client.send_customer_message feedback.to_json if feedback.present?
    user.customer_service_activities.create! openid: json[:FromUserName],
                                             msg_type: json[:MsgType],
                                             event: json[:Event],
                                             content: json[:Content]

    SlackSendJob.perform_later("[cable] 大四小冰客服 #{user.nickname}")
    #if user repleid, we have chance to send customer
    if json[:Content]
      queue = Aliyun::Mns::Queue["test24"]
      h = {
          user_id: user.id,
          event: 'customer-service-text',
      }
      #queue24
      res24 = queue.send_message JSON(h), {:DelaySeconds => 82800, :Priority => 10}
      puts "=====  aliyun mns queue 24 ====="
      puts res24.body
      res48 = queue.send_message JSON(h), {:DelaySeconds => 169200, :Priority => 10}
      puts "=====  aliyun mns queue 48 ====="
      puts res48.body
    end
    render plain: 'success'
  end


  def mini_app_customer_service_zhaopin
    json = JSON(request.body.read).symbolize_keys
    puts json
    openid = json[:FromUserName]
    user = User.find_by miniapp_openid: openid
    payload = {
        image:
            {
                media_id: 'Lyh-e3WZv3HYtZXCppW1UH0dUck51Ne2CBTmBisnrW4Em_49ljgsWyeC0NutynsV'
            }
    }
    wechat_mini_app_client = WechatMiniAppClient.new('wx8887d1994c33935c', '209161ceb742e880116fdf6f6414f997')
    wechat_mini_app_client.send_customer_message openid, 'image', payload
    SlackSendJob.perform_later("[cable] 大四小冰招聘版 #{user.human_resource_info.company} - #{user.nickname}")
    render plain: 'success'
  end

end
