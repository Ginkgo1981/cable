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

  before_action :find_user_by_token!, only: [:get_word_list, :get_book_productions, :get_user_lesson,:get_lesson, :get_schedules, :get_production, :buy_production]


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

  def get_user_lesson
    user_lesson = @user.user_lessons.find_by reading_date: params[:date]
    render json: {code: 0, user_lesson: user_lesson.try(:mini_format)}
  end

  def get_word_list
    user_lesson = @user.user_lessons.find_by reading_date: params[:date]
    word_list = user_lesson.lesson.lesson_words
    render json: {code: 0, word_list: word_list}
  end


end
