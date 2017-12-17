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

class Book < ApplicationRecord
  has_many :articles, dependent: :destroy
  def self.find_or_create json
    book = Book.find_by book_name: json['book_name']
    if book.blank?
      book = Book.create! book_name: json['book_name'],
                   book_name_cn: json['book_name_cn'],
                   book_cover_img_url: json['book_cover_img_url']

    end
    book
  end

end
