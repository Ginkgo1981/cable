class MembersController < ApplicationController

  before_action :find_user_by_token!, only: [:points_activities,:daily_checkin,
      :recognize, :get_reading_stats, :invitees,:bind_cell, :wechat_group, :wechat_phone, :update_profile, :my_resumes,
                                             :applying_job, :applied_jobs, :is_applied,:bind_hr_info, :read_business_card,
                                             :bookmarking_job, :is_bookmarked, :bookmarked_jobs, :deliver_resume_to_email]
  
  before_action :init_mini_app_params, only: [:mini_app_authorization, :wechat_group, :wechat_phone]

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


  def points_activities
    point_activities = @user.point_activities
    render json: {code: 0, point_activities: point_activities.map(&:format)}
  end

  def daily_checkin
    res = @user.daily_checkin
    render json: res
  end

  def reward_share_wechat_moment

    user = User.find_by id: params[:user_id]
    res =  user.reward_share_wechat_moment
    render json: res
  end


  def recognize
    qiniu_key = params[:qiniu_key]
    client = BaiduClient.new
    text = client.recognize qiniu_key
    puts "======== text "
    puts text
    talk_topic = TalkTopic.find_by id: params[:topic_id]
    thread = TalkThread.where(talk_topic: talk_topic, user: @user).first

    if thread
      thread.audio_url= "https://images.gaokao2017.cn/#{qiniu_key}"
      thread.recognize_result = text
      thread.retry_count = thread.retry_count + 1
      thread.save
    else
      thread = TalkThread.create! talk_topic: talk_topic,
                                  user: @user,
                                  audio_url: "https://images.gaokao2017.cn/#{qiniu_key}",
                                  recognize_result: text
    end
    render json: {code: 0, thread: thread.format}
  end

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
    staff = Student.find_by union_id: info[:unionid]
    render json: {code: 0, member: staff.membership}
  end


  def get_web_share_info
    user = User.find_by id: params[:user_id]
    render json: {code: 0, share_info: user.share_info}
  end

  def get_reading_stats
    stats = @user.stats
    render json: {stats: stats}
  end

  def update_profile
    @user.update params.permit(:university, :major, :latitude, :name, :avatar, :longitude, industry_tags: [], skill_tags: [])
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
    session = wx_get_session_key(code, @app_id, @app_secret)
    session_key = session['session_key']
    encrypted_data = params[:encrypted_data]
    iv = params[:iv]
    info = decrypt(session_key, @app_id, encrypted_data, iv).symbolize_keys
    user = User.find_by miniapp_openid: info[:openId]
    if user.nil?
      user = User.find_by union_id: info[:unionId]
    end

    binding.pry
    if user
      # if user.union_id.blank?
      #   user.union_id = info[:unionId]
      #   user.save!
      #   puts '====save union id===='
      #   puts user.union_id
      # end
      # if user.miniapp_openid.blank?
      #   user.miniapp_openid = info[:openId]
      #   user.save!
      #   puts '====save miniapp_openid ===='
      #   puts user.miniapp_openid
      # end

      user.update! union_id: info[:unionId],
                   miniapp_openid: info[:openId],
                   nickname: info[:nickName],
                   sex: info[:gender],
                   language: info[:language],
                   city: info[:city],
                   province: info[:province],
                   headimgurl: info[:avatarUrl]



    else
      user = User.create! miniapp_openid: info[:openId],
                                nickname: info[:nickName],
                                sex: info[:gender],
                                language: info[:language],
                                city: info[:city],
                                province: info[:province],
                                headimgurl: info[:avatarUrl],
                                union_id: info[:unionId],
                                type: @type
      SlackSendJob.perform_later("[cable] register #{user.type} #{user.nickname}")
      user.resumes.create! if user.is_a? Student
    end
    render json: {code: 0, member: user.membership, session_key: session_key}
  end

  def wechat_group
    encrypted_data = params[:encrypted_data]
    session_key = params[:session_key]
    iv = params[:iv]
    info = decrypt(session_key, @app_id, encrypted_data, iv).symbolize_keys
    openGId = info[:openGId]
    group = Group.find_or_create_by! group_no: openGId
    group.users << @user
    render json: {code: 0, msg: 'succ'}
  end

  def wechat_phone
    encrypted_data = params[:encrypted_data]
    session_key = params[:session_key]
    iv = params[:iv]
    info = decrypt(session_key, @app_id, encrypted_data, iv).symbolize_keys
    @user.cell = info[:phoneNumber]
    @user.save!
    render json: {code: 0, member: @user.membership}
  end

  def bind_hr_info
    hr_info_params = params[:hr_info].permit(:addr, :company, :department, :email, :name, :tel_cell, :tel_work, :title)
    @user.create_human_resource_info hr_info_params
    render json: {code: 0, member:@user.membership}
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
    # if @user.red_packs.where(event: 'deliver').size == 0
    #   amount = (100..200).to_a.sample
    #   @user.red_packs.create! amount: amount, event: 'deliver'
    #   if @user.mp_openid
    #     WechatRedpack.send_redpack amount, @user.mp_openid
    #   end
    # end
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
    # if @user.red_packs.where(event: 'deliver').size == 0
    #   amount = (100..200).to_a.sample
    #   @user.red_packs.create! amount: amount, event: 'deliver'
    #   if @user.mp_openid
    #     # WechatRedpack.send_redpack amount, @user.mp_openid
    #   end
    # end
    SlackSendJob.perform_later("[cable] deliver_resume_to_email #{@user.nickname} #{to}")
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

  # private
  def init_mini_app_params
    if params[:app_name] == '大四小冰'
      @app_id = 'wx0f381a5501cad4a6'
      @app_secret = 'c03ee61337e4273ae5c89c186e95517c'
      @type = 'Student'
    elsif params[:app_name] == '百草英语'
      @app_id = 'wxbeddbe15b456a582'
      @app_secret = 'd043773699dbba089d49592984a2e638'
      @type = 'Reader'
    else
      @app_id = 'wx8887d1994c33935c'
      @app_secret = '209161ceb742e880116fdf6f6414f997'
      @type = 'HumanResource'
    end
  end

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
