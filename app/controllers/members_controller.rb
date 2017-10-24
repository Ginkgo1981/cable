class MembersController < ApplicationController

  before_action :find_user_by_token!, only: [:invitees,:bind_cell, :wechat_group, :wechat_phone, :update_profile, :my_resumes,
                                             :applying_job, :applied_jobs, :is_applied,:bind_hr_info, :read_business_card,
                                             :bookmarking_job, :is_bookmarked, :bookmarked_jobs, :deliver_resume_to_email]

  # before_action :find_entity_by_dsin!, only: [:like_comment, :forward_wishcard]


  #HR or staff
  # def wechat_open_authorization
  #   wechat_client = WechatOpenClient.new
  #   if params[:openid].present? && params[:access_token].present?
  #     openid = params[:openid]
  #     access_token = params[:access_token]
  #   else
  #     access_token, openid = wechat_client.get_access_token params[:code]
  #   end
  #   user = User.find_by openweb_openid: openid
  #   (render json: {code: 0, member: user.membership} and return) if user
  #   (render json: {code: 0, openid: openid, access_token: access_token} and return) unless params[:cell].present?
  #   cell = Cell.find_by cell: params[:cell], code: params[:sms_code]
  #   raise CableException::CellCodeError unless cell
  #   info = wechat_client.get_user_info(access_token, openid).symbolize_keys!
  #   staff = Staff.create! openweb_openid: info[:openid],
  #                         nickname: info[:nickname],
  #                         sex: info[:sex],
  #                         language: info[:language],
  #                         city: info[:city],
  #                         province: info[:province],
  #                         headimgurl: info[:headimgurl],
  #                         union_id: info[:unionid],
  #                         cell: params[:cell]
  #   render json: {code: 0, member: staff.membership}
  # end



  def wechat_open_authorization
    wechat_client = WechatOpenClient.new
    if params[:openid].present? && params[:access_token].present?
      openid = params[:openid]
      access_token = params[:access_token]
    else
      access_token, openid = wechat_client.get_access_token params[:code]
    end
    # user = User.find_by openweb_openid: openid
    # (render json: {code: 0, member: user.membership} and return) if user
    # (render json: {code: 0, openid: openid, access_token: access_token} and return) unless params[:cell].present?
    # cell = Cell.find_by cell: params[:cell], code: params[:sms_code]
    # raise CableException::CellCodeError unless cell
    info = wechat_client.get_user_info(access_token, openid).symbolize_keys!
    staff = User.find_by union_id: info[:unionid]
    render json: {code: 0, member: staff.membership}
  end





  def update_profile
    @user.update params.permit(:university, :major, :latitude, :longitude, industry_tags: [], skill_tags: [])
    render json: {code: 0, msg: 'succ'}
  end

  def invitees
    invitees = @user.invitees
    render json: invitees,
           meta: {code: 0},
           each_serializer: StudentSerializer
  end

  #student
  def mini_app_authorization
    code = params[:code]
    if params[:app_name] == '求职小冰'
      app_id = 'wx0f381a5501cad4a6'
      app_secret = 'c03ee61337e4273ae5c89c186e95517c'
      type = 'Student'
    else
      app_id = 'wx8887d1994c33935c'
      app_secret = '209161ceb742e880116fdf6f6414f997'
      type = 'HumanResource'
    end
    session = wx_get_session_key(code, app_id, app_secret)
    session_key = session['session_key']
    encrypted_data = params[:encrypted_data]
    iv = params[:iv]
    info = decrypt(session_key, app_id, encrypted_data, iv).symbolize_keys

    user = User.find_by miniapp_openid: info[:openId]
    unless user
      user = User.create! miniapp_openid: info[:openId],
                                nickname: info[:nickName],
                                sex: info[:gender],
                                language: info[:language],
                                city: info[:city],
                                province: info[:province],
                                headimgurl: info[:avatarUrl],
                                union_id: info[:unionId],
                                type: type
       user.resumes.create! if user.is_a? Student
    end
    #inviter
    if params[:inviter_id] && student.id != params[:inviter_id]
      inviter = User.find_by id: params[:inviter_id]
      inviter.invitees << student if inviter
    end
    render json: {code: 0, member: user.membership, session_key: session_key}
  end

  def wechat_group
    if params[:app_name] == '求职小冰'
      app_id = 'wx0f381a5501cad4a6'
      app_secret = 'c03ee61337e4273ae5c89c186e95517c'
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
    if params[:app_name] == '求职小冰'
      app_id = 'wx0f381a5501cad4a6'
      app_secret = 'c03ee61337e4273ae5c89c186e95517c'
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

  def bind_hr_info
    hr_info_params = params[:hr_info].permit(:addr, :company, :department, :email, :name, :tel_cell, :tel_work, :title)
    @user.create_human_resource_info hr_info_params
    render json: {code: 0}
  end


  def read_business_card
    hr_info = AliyunServices.get_business_card params[:qiniu_key]
    render json: {code: 0, data: hr_info}
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

  def bookmarking_job
    job = Job.find_by id: params[:job_id]
    unless @user.bookmarking_jobs.exists?(job.id)
      @user.bookmarking_jobs << job
    end
    render json: {code: 0, msg: 'succ'}
  end

  def is_bookmarked
    job = Job.find_by id: params[:job_id]
    bookmarked = @user.bookmarking_jobs.exists?(job) ? 1 :0
    render json: {code: 0, data: {bookmarked: bookmarked}}
  end


  def applying_job
    user_job = UserJob.create! user_id: @user.id,
                    resume_id: @user.resumes[0].id,
                    job_id: params[:job_id],
                    company_id: params[:company_id]
    if @user.red_packs.where(event: 'deliver').size == 0
      amount = (100..200).to_a.sample
      @user.red_packs.create! amount: amount, event: 'deliver'
      if @user.mp_openid
        WechatRedpack.send_redpack amount, @user.mp_openid
      end
    end
    render json: {code: 0, msg: 'succ'}
  end

  def applied_jobs
    user_jobs = @user.user_jobs
    render json: user_jobs,
           each_serializer: UserJobSerializer,
           meta: {code: 0}
  end

  def deliver_resume_to_email
    to = params[:to]
    resume = @user.resumes.first
    binding.pry
    if @user.red_packs.where(event: 'deliver').size == 0
      amount = (100..200).to_a.sample
      @user.red_packs.create! amount: amount, event: 'deliver'
      if @user.mp_openid
        WechatRedpack.send_redpack amount, @user.mp_openid
      end
    end

    HrMailer.new.welcome_email(to, resume.format_for_email).deliver!
    render json:{code: 0}
  end

  def is_applied
    job = Job.find_by id: params[:job_id]
    applied = @user.jobs.exists?(job) ? 1 : 0
    render json: {code: 0, data: {applied: applied}}
  end


  def bookmarked_jobs
    jobs = @user.bookmarking_jobs
    render json: jobs,
           each_serializer: JobSerializer,
           meta: {code: 0}
  end

  def forward_job
    job = Job.find_by id: params[:id]

    group  = Group.find_or_create_by! group_id: params[:group_id]
    wishcard.following_groups << group unless wishcard.following_groups.exists? group
    render json: {code: 0, msg: 'succ'}
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
end
