namespace :daily do
  desc 'send_template_message'
  task send_template_message: :environment do
    Reader.all.each do |user|
      if user.mp? && user.role == 1
        puts '==== sending ====='
        puts user.nickname
        wechat_oa_client = WechatOaClient.new
        first_value =
<<EOM
百草英语 | 今日阅读提醒

hi~你未完成今日阅读, 别忘了哟~

EOM

        keyword1_value =
            <<EOM
《小王子》
EOM

        remark_value =
            <<EOM

点击进入小程序开始阅读>>

备注: 如你已完成阅读,请忽视此消息

EOM
        payload =
            {
                touser: user.mp_openid,
                template_id: 'rRjhO2FPqxpHbrEMif224uBeTo6K7KgXvA95gJYMHLo',
                miniprogram:{
                    appid: 'wxbeddbe15b456a582',
                    pagepath: 'pages/loading-page/loading-page'
                },
                data:{
                    first: {
                        value: first_value
                    },
                    keyword1:{
                        value: keyword1_value,
                        color: '#ff0000'
                    },
                    keyword2: {
                        value: Time.now.strftime('%Y-%m-%d')
                    },
                    remark:{
                        value: remark_value,
                    }
                }
            }
        res = wechat_oa_client.send_template_message(payload)



      end
    end
  end

  desc 'send_ping_message'
  task send_ping_message: :environment do
    Reader.all.each do |user|
      if user.mp_openid
        user_lesson = user.user_lessons.find_by reading_date: '2018-02-01'
        if user_lesson && user_lesson.send_checkin_notify == 0 && user_lesson.answers.present?
          wechat_oa_client = WechatOaClient.new
          payload =
              {
                  touser: user.mp_openid,
                  template_id: 'ubhAAEJtgAJMfhohWnB-B9BSA7_TMEzDLpMQcF3liis',
                  url: "https://files.gaokao2017.cn/share/#{user.id}",
                  data:{
                      first: {
                          value: '恭喜完成今日的阅读计划'
                      },
                      keyword1:{
                          value: '百草英语'
                      },
                      keyword2: {
                          value: '每日阅读签到'
                      },
                      keyword3: {
                          value: Time.now.strftime('%Y-%m-%d')
                      },
                      remark:{
                          value:'点击查看今日阅读报告'
                      }
                  }
              }
          puts "=== send to #{user.nickname} ======="
          wechat_oa_client.send_template_message(payload)
          user_lesson.send_checkin_notify = 1
          user_lesson.save
        end
      end
    end
  end





end
