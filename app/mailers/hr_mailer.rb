class HrMailer < ApplicationMailer

  # default from: '陈健 <job@radarly.cn>'
  default from: 'job@radarly.cn'


  def welcome_email(to, resume)
    resume.symbolize_keys!
    delivery_options = {user_name: 'job@radarly.cn',
                        password: 'DVg0ZurdT2s',
                        address: 'smtpdm.aliyun.com'}
    body = <<EOM
        你好,<br/>
        这是#{resume[:university]} #{resume[:major]} #{resume[:name]}的简历,为确保求职者信息的安全, 请你的微信扫描下面的二维码查看.
        <br/>
          <img src="#{resume[:qr_code]}"/>
        <br/>
        本邮件由微信小程序大四小冰代发,请不要直接回复.
        <br/>
EOM

    mail(to: to,
         body: body,
         content_type: 'text/html',
         subject: "#{resume[:university]} #{resume[:major]} #{resume[:name]}的简历,请查收",
         delivery_method_options: delivery_options)
  end


end
