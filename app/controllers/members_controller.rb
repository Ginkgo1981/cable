class MembersController < ApplicationController

  before_action :find_user_by_token!, only: [:update_teacher, :bind_cell, :bind_sat, :follow,
                                             :following_teachers, :following_universities, :following_students, :following_skycodes,
                                             :wechat_group,:wechat_phone,
                                             :like_comment,:update_profile,
                                             :my_resumes]

  # before_action :find_entity_by_dsin!, only: [:like_comment, :forward_wishcard]


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

  def update_profile
    @user.update params[:requestParams].permit(:latitude,:longitude).to_h
    render json: {code: 0, msg: 'succ'}
  end

  #student
  def mini_app_authorization
    code = params[:code]
    if params[:app_name] == '天马志愿'
      app_id = 'wxdfbc374fc090fd7c'
      app_secret = '6f851272e083c60764ccf17ca956379d'
    else
      app_id = 'wx8887d1994c33935c'
      app_secret = '209161ceb742e880116fdf6f6414f997'
    end
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

      student.resumes.create!
    end
    render json: {code: 0, member: user.membership, session_key: session_key}
  end

  def wechat_group
    if params[:app_name] == '天马志愿'
      app_id = 'wxdfbc374fc090fd7c'
      app_secret = '6f851272e083c60764ccf17ca956379d'
    else
      app_id = 'wx8887d1994c33935c'
      app_secret = '209161ceb742e880116fdf6f6414f997'
    end
    encrypted_data = params[:encrypted_data]
    session_key = params[:session_key]
    iv = params[:iv]
    info = decrypt(session_key, app_id, encrypted_data, iv).symbolize_keys
    openGId = info[:openGId]
    group = Group.find_or_create_by! group_no: openGId
    group.users << @user
    render json: {code: 0, msg: 'succ'}
  end

  def wechat_phone
    if params[:app_name] == '天马志愿'
      app_id = 'wxdfbc374fc090fd7c'
      app_secret = '6f851272e083c60764ccf17ca956379d'
    else
      app_id = 'wx8887d1994c33935c'
      app_secret = '209161ceb742e880116fdf6f6414f997'
    end
    encrypted_data = params[:encrypted_data]
    session_key = params[:session_key]
    iv = params[:iv]
    info = decrypt(session_key, app_id, encrypted_data, iv).symbolize_keys

    @user.cell = info[:phoneNumber]
    @user.save!
    render json: {code: 0, msg: 'succ'}
  end

  def follow
    bean = Bean.find_by_dsin params[:dsin]
    if @student
      @student.following_universities << bean if bean.is_a? University
      @student.following_teachers << bean if bean.is_a? Teacher
    end

    if @teacher
      @teacher.following_students << bean if bean.is_a? Student
    end
    render json: {code: 0, msg: '关注成功'}
  end

  def bind_cell
    Cell.verify_code! params[:cell], params[:sms_code]
    @user.update! cell: params[:cell], name: params[:name]
    @user.forms.create! form_id: params[:form_id], from: 'bind_cell'
    render json: {code: 0, message: 'succ'}
  end

  def send_sms_code
    cell = Cell.create! cell: params[:cell]
    cell.send_sms
    render json: {code: 0, message: 'succ'}
  end

  # def create_wishcard
  #   cities = (params[:cities] || []).map{|c| c['name']}
  #   universities = (params[:universities] || []).map{|c| c['name']}
  #   majors = (params[:majors] || []).map{|c| c['name']}
  #   wishcard = @user.create_wishcard cities: cities,
  #                                    universities: universities,
  #                                    majors: majors,
  #                                    introdution: params[:introdution]
  #   render json: {code: 0, dsin: wishcard.dsin}
  # end

  # def forward_wishcard
  #   binding.pry
  #   wishcard = @entity
  #   group  = Group.find_or_create_by! group_id: params[:group_id]
  #   wishcard.following_groups << group unless wishcard.following_groups.exists? group
  #   render json: {code: 0, msg: 'succ'}
  # end


  # #我在追
  # def following_teachers
  #   teachers = @student.following_teachers
  #   render json: teachers,
  #          each_serializer: TeacherSerializer,
  #          meta: {code: 0}
  # end
  #
  # def following_students
  #   students = @teacher.following_students
  #   render json: students,
  #          each_serializer: StudentSerializer,
  #          meta: {code: 0}
  # end


  # def like_comment
  #   @entity.like_comment(@user, params[:comment])
  #   likings = @entity.reload.likings.preload({user: [identity: :bean]})
  #   render json: likings,
  #          each_serializer: LikingSerializer,
  #          meta: {code: 0}
  # end


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
end
