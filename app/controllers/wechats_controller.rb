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
      wechat_mini_app_client = WechatMiniAppClient.new
      wechat_mini_app_client.send_customer_message openid, 'image',payload

    end
    render plain: 'success'
  end


  def mini_app_customer_service_zhaopin
    json = JSON(request.body.read).symbolize_keys
    puts json
    render plain: params[:echostr]
  end

end
