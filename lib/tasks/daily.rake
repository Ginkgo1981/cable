namespace :daily do

  desc 'send_template_message'
  task send_template_message: :environment do
    Reader.all.each do |user|
      if user.mp?
        puts '==== sending ====='
        puts user.nickname
        wechat_oa_client = WechatOaClient.new
        first_value =
<<EOM
百草阅读 | 今日阅读提醒
hi~你未完成今日阅读, 别忘了哟~
EOM

        remark_value =
            <<EOM
百草阅读 | 今日阅读提醒
hi~你未完成今日阅读, 别忘了哟~
EOM
        payload =
            {
                touser: user.mp_openid,
                template_id: 'rRjhO2FPqxpHbrEMif224uBeTo6K7KgXvA95gJYMHLo',
                miniprogram:{
                    appid: 'wx0020670ada444281',
                    pagepath: 'pages/loading-page/loading-page'
                },
                data:{
                    first: {
                        value: first_value,
                        color: '#173177'
                    },
                    keyword1:{
                        value: '《暗红习作》',
                        color: '#ff0000'
                    },
                    keyword2: {
                        value: Time.now.strftime('%Y-%m-%d'),
                        color: '#173177'
                    },
                    remark:{
                        value: remark_value,
                        color: '#173177'
                    }
                }
            }
        wechat_oa_client.send_template_message(payload)


      end
    end
  end


end
