# == Schema Information
#
# Table name: books
#
#  id                 :uuid             not null, primary key
#  book_name          :string
#  book_name_cn       :string
#  book_cover_img_url :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class BooksController < ApplicationController

  before_action :find_user_by_token!, only: [:get_mine_talk_topic, :get_word_list, :get_book_productions, :get_user_lesson,:get_lesson, :get_schedules, :get_production, :buy_production]

  def get_talk_topic #pure
    topic = TalkTopic.find_by talk_date: params[:date]
    render json: {code: 0, topic: topic.format}
  end

  def get_mine_talk_topic
    topic = TalkTopic.find_by talk_date: params[:date]
    thread = topic.talk_threads.where(user_id: @user.id).first
    render json: {code: 0, topic: topic.format, thread: thread.try(:format)}
  end

  def get_talk_thread
    thread = TalkThread.find_by id: params[:thread_id]
    render json: {code: 0, thread: thread.format}
  end


  def lessons_group_statistics
    stats = Reader.all.map{|r| [r.nickname, r.headimgurl, r.user_lessons.where(state: 1).count]}.sort_by{|a| -a[2]}
    render json: {code: 0, stats: stats}
  end

  def buy_production
    production = BookProduction.find_by id: params[:production_id]
    @user.buy_book_producton production
    render json: {code: 0, msg: '预定成功'}
  end

  def get_production
    book_production = BookProduction.find_by id: params[:production_id]
    state = @user.books.include? book_production.book
    render json: {code: 0, production: book_production.format, book_state: state ? 1 : 0}
  end

  def get_books
    books = Book.all
    render json: {code: 0, books: books.map{|book| book.format}}
  end

  def get_book_productions
    productions = BookProduction.all.map{|p| p.format_with_user(@user)}
    render json: {code: 0, productions: productions}
  end


  def get_schedules
    schedules = @user.user_lessons.where('reading_date <= ?', Time.now.to_date).order('reading_date').map{|ul| [ul.reading_date.strftime('%Y-%m-%d'), ul.state.to_i]}.to_h
    render json: {code: 0, schedules: schedules}
  end

  def get_questions
    user_lesson_id = params[:user_lesson_id]
    user_lesson = UserLesson.find user_lesson_id
    render json: {code: 0, user_lesson: user_lesson.format_of_questions}
  end

  def save_answers
    user_lesson = UserLesson.find_by id: params[:user_lesson_id]
    user_lesson.answers = params[:answers]
    user_lesson.save!


    #send a notification


    user = user_lesson.user
    puts '==== save answers ===='
    if user.mp_openid && user_lesson.reading_date == Time.now.strftime('%Y-%m-%d')
      puts '====== send template message ========'
      wechat_oa_client = WechatOaClient.new
      payload =
          {
              touser: user.mp_openid,
              template_id: 'ubhAAEJtgAJMfhohWnB-B9BSA7_TMEzDLpMQcF3liis',
              url: "https://files.gaokao2017.cn/share/#{user.id}",
              data:{
                  first: {
                      value: '恭喜完成今日的阅读计划'
                  },
                  keyword1:{
                      value: '百草阅读'
                  },
                  keyword2: {
                      value: '每日阅读签到'
                  },
                  keyword3: {
                      value: Time.now.strftime('%Y-%m-%d')
                  },
                  remark:{
                      value:'点击查看今日阅读报告'
                  }
              }
          }
      wechat_oa_client.send_template_message(payload)
      user_lesson.send_checkin_notify = 1
      user_lesson.save
    end
    render json: {code: 0, msg: 'succ'}
  end

  def get_user_lesson
    user_lesson = UserLesson.where(reading_day: 20).last #hotfix
    render json: {code: 0, user_lesson: user_lesson.try(:mini_format)}
  end

  def get_lesson
    # params[:date] = '2017-11-06'
    expired_date = Date.new(2018,1,28)
    if expired_date > Date.parse(params[:date])
      render json: {code: 1, msg: '由于版权等原因,已过期课程不能播放'}
      return
    end
    user_lesson = @user.user_lessons.find_by reading_date: params[:date]
    render json: {code: 0, user_lesson: user_lesson.format}
  end

  def get_word_list
    user_lesson = @user.user_lessons.find_by reading_date: params[:date]
    word_list = user_lesson.lesson.lesson_words
    render json: {code: 0, word_list: word_list}
  end




end
