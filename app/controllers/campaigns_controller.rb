class CampaignsController < ApplicationController
  before_action :find_user_by_token!, only: [:binding_skycode, :campaign_list, :skycode_list, :student_scan_skycode, :teacher_scan_skycode]
  before_action :find_entity_by_dsin!, only:[:binding_skycode, :campaign_list, :skycode_list, :create_skycode, :student_scan_skycode, :teacher_scan_skycode]

  def campaign_list
    campaigns = @entity.campaigns
    render json: campaigns,
           meta: {code: 0},
           each_serializer: CampaignSerializer
  end

  def binding_skycode  #供现场的老师绑定
    raise CableException::SkycodeNotFound unless @entity.is_a? Skycode
    raise CableException::SkycodeAlreadyBinded if @entity.using?
    @entity.name = params[:name]
    @entity.teacher = @teacher
    @entity.university = @university
    @entity.save!
    skycodes = @teacher.skycodes.reload.reverse_order
    render json: skycodes,
           meta: {code: 0},
           each_serializer:SkycodeSerializer
  end

  def skycode_list
    skycodes = @entity.skycodes.reverse_order
    render json: skycodes,
           meta: {code: 0},
           each_serializer:SkycodeSerializer
  end

  #学生扫码
  def student_scan_skycode
    skycode = Bean.find_by_dsin(params[:skycode_dsin])
    skycode.students << @student #bind to skycode
    skycode.campaign && (skycode.campaign.students << @student)  #bind to campaign
    skycode.university && (skycode.university.students << @student)  #bind to university
    render json: {code: 0, msg: "成功关注 #{skycode.university.name}"}
  end

  # #老师扫码
  # def teacher_scan_skycode
  #   binding.pry
  #   skycode = Bean.find_by_dsin(params[:skycode_dsin])
  #   skycode.university = @university
  #   skycode.teacher = @teacher
  #   render json: {code: 0, msg: 'succ'}
  # end

end
