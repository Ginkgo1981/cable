class HrMailer < ApplicationMailer

  default from: 'job@radarly.cn'


  def welcome_email()
    delivery_options = {user_name: 'job@radarly.cn',
                        password: 'DVg0ZurdT2s',
                        address: 'smtpdm.aliyun.com'}


    body = multiline_string = <<EOM
This is a very long string <a href='http://www.baidu.cn'> baidu </a>


  <img src="https://images.gaokao2017.cn/ev25-qr-code-500.png"/>


that contains interpolation
like #{4 + 5} \n\n
EOM


    mail(to: 'jian.chen@skymatters.com',
         body: body,
         content_type: 'text/html',
         subject: 'QRCode',
         delivery_method_options: delivery_options)
  end


end
