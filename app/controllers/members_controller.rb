class MembersController < ApplicationController

  before_action :find_user!, only: %w(bind_cell bind_sat)


  #teacher
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
    (render json: {code: 0, openid: openid, access_token: access_token} and return) unless params[:cell].present?
    cell = Cell.find_by cell: params[:cell], code: params[:sms_code]
    raise CableException::CellCodeError unless cell
    teacher = Teacher.find_by cell: params[:cell]
    raise CableException::TeacherNotFound unless teacher
    info = wechat_client.get_user_info(access_token, openid).symbolize_keys!
    user = User.create! openweb_openid: info[:openid],
                        nickname: info[:nickname],
                        sex: info[:sex],
                        language: info[:language],
                        city: info[:city],
                        province: info[:province],
                        headimgurl: info[:headimgurl],
                        union_id: info[:unionid],
                        cell: params[:cell]
    teacher.user = user
    render json: {code: 0, member: user.membership}
  end


  #student
  def mini_app_authorization
    code = params[:code]
    app_id = 'wxdfbc374fc090fd7c'
    app_secret = '6f851272e083c60764ccf17ca956379d'
    session = wx_get_session_key(code, app_id, app_secret)
    session_key = session['session_key']
    encrypted_data = params[:encrypted_data]
    iv = params[:iv]
    info = decrypt(session_key, app_id, encrypted_data, iv).symbolize_keys
    user = User.find_by miniapp_openid: info[:openId]
    unless user
      student = Student.create!
      user = student.create_user miniapp_openid: info[:openId],
                                 nickname: info[:nickName],
                                 sex: info[:gender],
                                 language: info[:language],
                                 city: info[:city],
                                 province: info[:province],
                                 headimgurl: info[:avatarUrl],
                                 union_id: info[:unionId]
    end
    render json: {code: 0, member: user.membership}
  end





  def bind_cell
    Cell.verify_code! params[:cell], params[:sms_code]
    @user.update! cell: params[:cell], name: params[:name]
    @user.forms.create! form_id: params[:form_id], from: 'bind_cell'
    render json: { code: 0, message: 'succ' }
  end


  def bind_sat
    @user.forms.create! form_id: params[:form_id], from: 'bind_sat'
    student = @user.identity
    student.sat_score = params[:sat]
    student.save
    render json: { code: 0, message: 'succ' }
  end

  def send_sms_code
    cell = Cell.create! cell: params[:cell]
    cell.send_sms
    render json: { code: 0, message: 'succ' }
  end

  private
  def decrypt(session_key, app_id, encrypted_data, iv)
    pc = WechatMiniappDecrypt.new(app_id, session_key)
    pc.decrypt(encrypted_data, iv)
  end

  def wx_get_session_key(code, app_id, app_secret)
    uri = URI('https://api.weixin.qq.com/sns/jscode2session')
    params = {appid: app_id,
              secret: app_secret,
              js_code: code,
              grant_type: 'authorization_code'}

    uri.query = URI.encode_www_form(params)
    resp = Net::HTTP.get_response(uri)
    if resp.is_a?(Net::HTTPSuccess) && !resp.body['errcode']
      return JSON(resp.body)
    else
      raise("get_session_key fail")
    end
  end

  def find_user!
    @user = User.find_by! token: params[:token]
  end
end
