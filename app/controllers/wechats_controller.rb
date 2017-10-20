class WechatsController < ApplicationController

  #receive WeChat notification
  def echo
    case params[:xml][:MsgType]
      when 'text'
      when 'event'
        case params[:xml][:Event].downcase
          when 'subscribe'
            puts "======= "
            puts params[:xml]
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
