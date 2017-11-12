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
    user = User.find_by union_id: user_info[:unionid]
    user.mp_openid = openid
    user.save
    if event == 'subscribe'
      if user.red_packs.size == 0
        amount = (100..200).to_a.sample
        user.red_packs.create! amount: amount, event: 'subscribe'
        SlackSendJob.perform_later("[cable] send_redpack #{user.nickname} #{amount}")
        WechatRedpack.send_redpack amount, openid
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
    unless user.mp_openid
      payload = {
          image:
              {
                  media_id:"Z3a7BFjDsWUZmt-Ww7OETu7sPMUOMgJjuj8IWF8HTVI0DeuZJwpVf1c23H3oEVah"
              }
      }
      wechat_mini_app_client = WechatMiniAppClient.new('wx0f381a5501cad4a6','c03ee61337e4273ae5c89c186e95517c')
      wechat_mini_app_client.send_customer_message openid, 'image',payload
      SlackSendJob.perform_later("[cable] 大四小冰客服 #{user.nickname}")
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
                media_id:'Lyh-e3WZv3HYtZXCppW1UH0dUck51Ne2CBTmBisnrW4Em_49ljgsWyeC0NutynsV'
            }
    }
    wechat_mini_app_client = WechatMiniAppClient.new('wx8887d1994c33935c','209161ceb742e880116fdf6f6414f997')
    wechat_mini_app_client.send_customer_message openid, 'image',payload
    SlackSendJob.perform_later("[cable] 大四小冰招聘版 #{user.human_resource_info.company} - #{user.nickname}")
    render plain: 'success'
  end

end
