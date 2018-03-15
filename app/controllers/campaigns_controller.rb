# == Schema Information
#
# Table name: campaigns
#
#  id             :uuid             not null, primary key
#  bucket_id      :uuid
#  bucket_type    :string
#  start_at       :date
#  end_at         :date
#  duration       :integer
#  sell_state     :integer
#  completed_days :integer
#  missed_days    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  name           :string
#  tags           :text             is an Array
#

class CampaignsController < ApplicationController
  before_action :find_user_by_token!, only: [:get_questions, :list, :get_lesson_by_date, :get_schedules, :finish_lesson, :get_lesson,:get_bucket_item, :get_campaign_activities, :get_campaign_members,:get_campaign_index,:my_campaigns,:buy_campaign, :get_promotion_campaign]

  def share_settings

    render json: {
        code: 1,
        share_count:1,
        black_list: ['e851ff90-6d27-4248-b627-0aa11ce8db69', 'c423fe48-9bd1-4216-baaa-c881ff128904']
    }

  end

  def list
    if @user.role == 1
      campaigns = Campaign.all.map(&:format)
    else
      campaigns = Campaign.where(sell_state: 1).map(&:format)
    end
    my_campaigns_ids = @user.campaigns.ids
    cs = campaigns.map do |c|
      if my_campaigns_ids.include?(c[:id])
        c['joined'] = 1
      else
        c['joined'] = 0
      end
      c
    end
    render json: {code: 0, campaigns: cs}
  end

  def get_promotion_campaign
    #再次参加
    campaign = Campaign.find_by id: params[:id]
    res, msg = @user.campaign_state campaign
    render json: {code: 0, campaign: campaign.format, user_campaign_state: {flag: res,msg: msg}}
  end

  def get_campaign_index
    campaign = Campaign.find_by id: params[:id]
    user_campaign = UserCampaign.find_by user: @user,
                                         campaign: campaign
    today_finished, next_bucket_item = user_campaign.next_bucket_item
    render json: {code: 0,
                  campaign: campaign.format,
                  user_campaign: {
                      done_items_count: user_campaign.done_items_count,
                      total_items_count: user_campaign.total_items_count,
                      next_bucket_item: next_bucket_item,
                      today_finished: today_finished
                  }
    }
  end


  def get_campaign_members
    #todo
    campaign = Campaign.find_by id: params[:id]
    members =  campaign.users.first(50)
    render json: {code: 0, members: members.map(&:format)}
  end

  def get_campaign_activities
    campaign = Campaign.find_by id: params[:id]
    activities = campaign.campaign_activities.order(created_at: :desc).first(30)
    render json: {code: 0, activities: activities.map(&:format)}
  end

  def buy_campaign
    campaign = Campaign.find_by id: params[:id]
    # if @user.joined_campaign?(campaign)
    #   (render json: {code: 1, msg: '已参加活动'}) and return
    # end
    res, message = @user.join_campaign! campaign
    if res
      render json: {code: 0, msg: '加入成功'}
    else
      render json: {code: -1, msg: '加入失败'}
    end
  end

  def my_campaigns
    campaigns = @user.campaigns
    render json: {code: 0, campaigns: campaigns.map(&:format)}
  end

  def get_questions
    lesson = Lesson.find_by id: params[:lesson_id]
    answers = UserCampaignProgress.where(bucket_item: lesson, user: @user).first.try(:answers)
    render json: {code: 0, questions: lesson.lesson_questions.map { |l| l.format }, answers: answers}
  end

  def get_lesson
    lesson = Lesson.find_by id: params[:lesson_id]
    render json: {code: 0, lesson: lesson.format}
  end

  def get_lesson_terms
    lesson = Lesson.find_by id: params[:lesson_id]
    terms = lesson.terms
    render json: {code: 0, terms: terms}
  end

  def get_lesson_by_date
    user_campaign_progress = @user.user_campaign_progresses.find_by task_date: params[:date]
    lesson = user_campaign_progress.bucket_item
    render json: {code: 0, lesson: lesson.format}
  end

  def get_schedules
    schedules = @user.user_campaign_progresses.where(campaign_id: params[:campaign_id]).map{|ul| [ul.task_date.strftime('%Y-%m-%d'), 1]}.to_h
    render json: {code: 0, schedules: schedules}
  end

  def finish_lesson #save_answers
    user_campaign = @user.user_campaigns.find_by campaign_id: params[:campaign_id]
    lesson = Lesson.find_by id: params[:lesson_id]
    user_campaign.mark_as_done lesson, params[:answers] || []
    puts '==== send a notification ===='
    # if @user.mp_openid
    #   puts '====== send template message ========'
    #   wechat_oa_client = WechatOaClient.new
    #   payload =
    #       {
    #           touser: @user.mp_openid,
    #           template_id: 'ubhAAEJtgAJMfhohWnB-B9BSA7_TMEzDLpMQcF3liis',
    #           url: "https://files.gaokao2017.cn/share/#{@user.id}",
    #           data:{
    #               first: {
    #                   value: '恭喜完成今日的阅读计划'
    #               },
    #               keyword1:{
    #                   value: '百草阅读'
    #               },
    #               keyword2: {
    #                   value: '每日阅读签到'
    #               },
    #               keyword3: {
    #                   value: Time.now.strftime('%Y-%m-%d')
    #               },
    #               remark:{
    #                   value:'点击查看今日阅读报告'
    #               }
    #           }
    #       }
    #   wechat_oa_client.send_template_message(payload)
    # end
    render json: {code: 0, msg: 'succ'}
  end

end
