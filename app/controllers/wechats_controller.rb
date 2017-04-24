class WechatsController < ApplicationController

  def guide
    appid =  Rails.application.config_for('wechat')['AppID']
    redirect_url = "http://www.loop2x.cn/wechat/play?sky_code=#{params[:sky_code]}"
    scope  = 'snsapi_base'
    redirect_to "https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{appid}&redirect_uri=#{redirect_url}&response_type=code&scope=#{scope}"
  end

  #receive WeChat notification
  def echo
    welcome_article =  Rails.application.config_for('wechat_free_duty_article')['articles'][0]
    case params[:xml][:MsgType]
      when 'text'
        # render 'echo', formats: :xml and return
      when 'event'
        case params[:xml][:Event].downcase
          when 'subscribe'
            # WechatMessageJob.perform_now({openid: params[:xml][:FromUserName],article: welcome_article })
        end
    end
    render text: ''
  end


end
