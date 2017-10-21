class WechatsController < ApplicationController

  #receive WeChat notification
  def echo
    doc = Nokogiri::XML request.body.read
    openid = doc.css('FromUserName').text
    event = doc.css('Event').text

    wechat_client = WechatOaClient.new()

    access_token = wechat_client.get_access_token
    user_info = wechat_client.get_user_info(access_token, openid)
    puts user_info

    #红包发放的逻辑

    if event == 'subscribe'
      #todo
      WechatRedpack.send_redpack 101, openid
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
    payload = {
        image:
            {
                media_id:"59MulwFREhz7xPZxNSzmAuGxgX9RKKAdVmaJibYIIroKx5OMeGXz57XMg-7H7huu"
            }
    }
    wechat_mini_app_client = WechatMiniAppClient.new
    wechat_mini_app_client.send_customer_message openid, 'image',payload
    render plain: 'success'
  end

end
