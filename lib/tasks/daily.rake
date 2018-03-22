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

  desc 'reading_statistic'
  task reading_statistic: :environment do
    user_lessons = UserLesson.where(reading_date: 1.day.ago).where.not(answers: nil)
    text = "阅读情况: #{0.day.ago.strftime('%Y-%m-%d')} - #{user_lessons.size} \n"
    user_lessons.each do |ul|
      text += "#{ul.user.nickname.to_s} #{ul.user.cell.to_s} \n"
    end
    SlackService.alert text
  end

  desc 'user_exam_daily_prmmotion'
  task user_exam_daily_prmmotion: :environment do
    wechat_mini_app_client = WechatMiniAppClient.new('wxbeddbe15b456a582', 'd043773699dbba089d49592984a2e638')
    Form.pluck(:user_id).uniq.each do |user_id|
      user = User.find_by id: user_id
      if user
        form = user.forms.first
        template =
            {
                'touser': user.miniapp_openid,
                'template_id': '3qbH911jUMZpHzx9_0akjcr6wWM64IhYtZ3Pd37OdjA',
                'page': 'pages/exam-friend-defense-page/exam-friend-defense-page',
                'form_id': form.form_id,
                'data': {
                    'keyword1': {
                        'value': '你收到一个好友挑战'
                    },
                    'keyword2': {
                        'value': '你的好朋友喊你去答题',
                    }
                }
            }
        form.destroy
        wechat_mini_app_client.send_template_message template
      end
    end
  end
end
