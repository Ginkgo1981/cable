namespace :notice do


  desc 'send_as_customer_service'
  task send_as_customer_service: :environment do
    queue = Aliyun::Mns::Queue["test24"]
    msg = queue.receive_message
    msg.delete
    user_id = JSON(msg.body)['user_id']
    user =  User.find_by id: user_id
    miniapp_openid = user.miniapp_openid
    binding.pry
    miniapp_openid = 'opvsg0VHguzEeOtL2hGtznCjmg0g'
    feedback = {
        openid: miniapp_openid,
        msgtype: 'miniprogrampage',
        payload: {
            miniprogrampage: {
                title: '大四小冰 - 我们一起找工作',
                pagepath: 'pages/message-list-page/message-list-page',
                thumb_media_id: 'jywzzsKkmv0uR3e6S7wk9dt2X-6-rEL4mElBlzA92zD7GArvvFRkUf1qqtXW5lAK'
            }
        }
    }
    wechat_mini_app_client = WechatMiniAppClient.new('wx0f381a5501cad4a6', 'c03ee61337e4273ae5c89c186e95517c')
    wechat_mini_app_client.send_customer_message feedback.to_json
  end

end
