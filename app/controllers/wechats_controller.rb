class WechatsController < ApplicationController

  #receive WeChat notification
  def echo
    # welcome_article =  Rails.application.config_for('wechat_free_duty_article')['articles'][0]
    # case params[:xml][:MsgType]
    #   when 'text'
    #     # render 'echo', formats: :xml and return
    #   when 'event'
    #     case params[:xml][:Event].downcase
    #       when 'subscribe'
    #         # WechatMessageJob.perform_now({openid: params[:xml][:FromUserName],article: welcome_article })
    #     end
    # end
    puts "++++++++++++"
    puts params
    render text: params[:echostr]
  end

  def mini_app_customer_service
    json = JSON(request.body.read)
    puts json
    render plain: 'success'
  end

end
