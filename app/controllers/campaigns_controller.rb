class CampaignsController < ApplicationController
  before_action :find_user_by_token!, only: [:scan_skycode, :campaign_list, :skycode_list, :update_skycode]
  before_action :find_entity_by_dsin!, only: [:scan_skycode, :campaign_list, :skycode_list, :update_skycode]

  def campaign_list
    campaigns = @entity.campaigns
    render json: campaigns,
           meta: {code: 0},
           each_serializer: CampaignSerializer
  end

  def skycode_list
    skycodes = @entity.following_skycodes.reverse_order
    render json: skycodes,
           meta: {code: 0},
           each_serializer: SkycodeSerializer
  end


  def update_skycode
    @entity.name = params[:name]
    @entity.save
    render json: {code: 0, msg: '修改成功', entity: @entity.format}
  end


  def scan_skycode
    if @student
      @entity.followed_by_students << @student
      @entity.campaign && (@entity.campaign.followed_by_students << @student)
      @entity.university && (@entity.university.followed_by_students << @student)
    elsif @teacher
      if @entity.is_a? Skycode
        # raise CableException::SkycodeNotFound unless @entity.is_a? Skycode
        raise CableException::SkycodeAlreadyBinded if @entity.using?
        @entity.update_attributes name: params[:name],
                                  teacher: @teacher,
                                  university: @university

      elsif @entity.is_a? Student
        @teacher.followed_by_students << @entity
      end
    end
    render json: {code: 0, msg: '扫码成功', entity: @entity.format}
  end
end
