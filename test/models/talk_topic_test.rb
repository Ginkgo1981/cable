# == Schema Information
#
# Table name: talk_topics
#
#  id         :uuid             not null, primary key
#  talk_date  :string
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  banner     :string
#  chinese    :string
#  note       :string
#

require 'test_helper'

class TalkTopicTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
