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

class TalkThread < ApplicationRecord
  belongs_to :talk_topic
  belongs_to :user, class_name: Reader

  def format
    {
        id: self.id,
        talk_topic_id: self.id,
        user: self.user.format,
        audio_url: self.audio_url,
        score: self.score.to_i,
        matches: self.matches
    }
  end

  def matches
    results = recognize_result.split(/[\s|,|.]/)
    self.talk_topic.content.split(/[\s|,|.]/).map do |word|
      word = ', ' if word == ''
      results.include?(word) ? [word,1] : [word, 0]
    end
  end


end
