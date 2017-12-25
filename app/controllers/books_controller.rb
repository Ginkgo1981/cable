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

  before_action :find_user_by_token!, only: [:get_today,:get_lesson, :get_schedules]

  def get_lesson
    # params[:date] = '2017-11-06'
    user_lesson = @user.user_lessons.find_by reading_date: params[:date]
    render json: {code: 0, user_lesson: user_lesson.format}
  end

  def get_schedules
    today =Time.now.strftime('%Y-%m-%d')
    today_user_lesson =@user.user_lessons.find_by reading_date: today
    today_reading_day = today_user_lesson.try(:reading_day) || 100
    schedules = @user.user_lessons.where('reading_day <= ?', today_reading_day).order('reading_day').map{|ul| [ul.reading_date, ul.state.to_i]}.to_h
    # schedules = @user.user_lessons.map{|ul| {"#{ul.reading_date}":  ul.state.to_i}}
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
  end

  def get_today
    user_lesson = @user.user_lessons.find_by reading_date: params[:date]
    (render json: {code: 0, msg: '今日没有内空'})  and  return unless user_lesson
    task = {
        banner_info:
            {img_url:'http://ali.baicizhan.com/readin/images/banner-12.16.png',
                      url: ''
        },
        user_lesson: user_lesson.mini_format
    }
    render json: {code: 0, task: task}
  end


end
