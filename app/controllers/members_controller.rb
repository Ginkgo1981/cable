class MembersController < ApplicationController


  def wechat_open_authorization
    wechat_client = WechatOpenClient.new
    if params[:openid].present? && params[:access_token].present?
      openid = params[:openid]
      access_token = params[:access_token]
    else
      access_token, openid = wechat_client.get_access_token params[:code]
    end
    user = User.find_by openweb_openid: openid
    (render json: {code: 0, member: user.membership} and return) if user
    (render json: {code: 0, openid: openid,access_token: access_token} and return) unless params[:cell].present?
    cell = Cell.find_by cell: params[:cell], code: params[:sms_code]
    raise CableException::CellCodeError unless cell
    teacher = Teacher.find_by cell: params[:cell]
    raise CableException::TeacherNotFound unless teacher
    info = wechat_client.get_user_info(access_token, openid).symbolize_keys!
    user = User.create! openweb_openid: info[:openid],
                        nickname:       info[:nickname],
                        sex:            info[:sex],
                        language:       info[:language],
                        city:           info[:city],
                        province:       info[:province],
                        headimgurl:     info[:headimgurl],
                        union_id:       info[:unionid],
                        cell:           params[:cell]
    teacher.user = user
    render json: {code: 0, member: user.membership}
  end

  def send_sms_code
    cell = Cell.create! cell: params[:cell]
    cell.send_sms
    render json: {
        code: 0,
        message: 'succ'
    }
  end
end
