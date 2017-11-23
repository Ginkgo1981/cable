namespace :notice do


  desc 'send_customer_service'
  task send_customer_service: :environment do
    flag = 42
    while flag > 0
      begin
        flag -= 1
        puts flag
        queue = Aliyun::Mns::Queue['test24']
        msg = queue.receive_message
        msg.delete
        puts msg.body
        user_id = JSON(msg.body)['user_id']
        user =  User.find_by id: user_id
        miniapp_openid = user.miniapp_openid
        # miniapp_openid = 'opvsg0VHguzEeOtL2hGtznCjmg0g'
        feedback = {
            openid: miniapp_openid,
            msgtype: 'miniprogrampage',
            payload: {
                miniprogrampage: {
                    title: '大四小冰 - 我们一起找工作',
                    pagepath: 'pages/message-list-page/message-list-page',
                    thumb_media_id: 'F4lOY2nJiW4vUGWiC0quXoaDiKdNOoEEbao_-S8Kl6vhpPLL1q4WGucXXUFirI-z'
                }
            }
        }
        wechat_mini_app_client = WechatMiniAppClient.new('wx0f381a5501cad4a6', 'c03ee61337e4273ae5c89c186e95517c')
        res = wechat_mini_app_client.send_customer_message feedback.to_json
        puts res
      rescue => e
        puts e
      end

    end
  end


  desc 'send_template_messagei'
  task send_customer_service: :environment do


  end

end
