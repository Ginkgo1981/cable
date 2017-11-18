class WechatsController < ApplicationController

  #receive WeChat notification
  def echo
    doc = Nokogiri::XML request.body.read
    openid = doc.css('FromUserName').text
    event = doc.css('Event').text
    wechat_client = WechatOaClient.new()
    access_token = wechat_client.access_token
    user_info = wechat_client.get_user_info(access_token, openid).symbolize_keys
    puts user_info
    #红包发放的逻辑
    #todo user is nil
    user = User.find_by union_id: user_info[:unionid]
    if user
      user.mp_openid = openid
      user.save
      if event == 'subscribe'
        if user.red_packs.size == 0
          amount = (100..110).to_a.sample
          user.red_packs.create! amount: amount, event: 'subscribe'
          SlackSendJob.perform_later("[cable] send-redpack #{user.nickname} #{amount}")
          WechatRedpack.send_redpack amount, openid
        end
      end
    end
    render plain: 'success' #params[:echostr]
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
                      media_id: 'jywzzsKkmv0uR3e6S7wk9dt2X-6-rEL4mElBlzA92zD7GArvvFRkUf1qqtXW5lAK'
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
                    thumb_media_id: 'jywzzsKkmv0uR3e6S7wk9dt2X-6-rEL4mElBlzA92zD7GArvvFRkUf1qqtXW5lAK'
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
    user.customer_service_activities.create! openid: json[:ToUserName],
                                             msg_type: json[:MsgType],
                                             event: json[:Event],
                                             content: json[:content]

    SlackSendJob.perform_later("[cable] 大四小冰客服 #{user.nickname}")
    #if user repleid, we have chance to send customer
    if json[:Content]
      queue24 = Aliyun::Mns::Queue["test24"]
      h = {
          user_id: user.id
      }
      res = queue24.send_message JSON(h)
      puts res
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
