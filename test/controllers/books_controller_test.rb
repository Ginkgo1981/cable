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

require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
end
