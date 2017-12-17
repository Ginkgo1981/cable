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


  def get_article
    article =  Article.last
    render json: {code: 0, article: article.format}
  end


  def get_today
    todayTask = {
        todayDateTime:  '2017-12-16',
        banner_info: 
            {img_url:'http://ali.baicizhan.com/readin/images/banner-12.16.png',
                      url: ''
        },
        book: {
            book_cover_img_url: 'http://ali.baicizhan.com/readin/images/Cover-The-Sign-of-Four.png',
            current_chapter: 25,
            book_name: 'The Sign of Four',
            book_name_cn: '四签名'
        }
    }
    render json: {code: 0, todayTask: todayTask}
  end


end
