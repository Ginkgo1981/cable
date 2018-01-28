# == Schema Information
#
# Table name: lesson_lyrics
#
#  id         :uuid             not null, primary key
#  lesson_id  :uuid
#  ord        :integer          default(0)
#  sec        :float
#  en         :string
#  sc         :string
#  css        :string
#  pic        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class LessonLyricTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
