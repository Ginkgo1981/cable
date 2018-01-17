# == Schema Information
#
# Table name: talk_threads
#
#  id               :uuid             not null, primary key
#  talk_topic_id    :uuid
#  user_id          :uuid
#  audio_url        :string
#  score            :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  recognize_result :string
#

require 'test_helper'

class TalkThreadTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
