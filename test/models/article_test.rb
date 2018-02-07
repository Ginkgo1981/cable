# == Schema Information
#
# Table name: articles
#
#  id                :uuid             not null, primary key
#  book_id           :uuid
#  title_cn          :string
#  title_en          :string
#  previous          :string
#  audio_url         :string
#  audio_name        :string
#  lyric             :text             is an Array
#  questions         :hstore           is an Array
#  share_words       :text
#  share_img_url     :string
#  share_title       :string
#  teacher_notes_url :string
#  word_count        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
