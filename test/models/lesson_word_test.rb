# == Schema Information
#
# Table name: lesson_words
#
#  id         :uuid             not null, primary key
#  lesson_id  :uuid
#  word       :string
#  mean       :string
#  accent     :string
#  level      :integer
#  audio_url  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class LessonWordTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
