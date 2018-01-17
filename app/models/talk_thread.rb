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
#  matches          :text             is an Array
#

class TalkThread < ApplicationRecord
  belongs_to :talk_topic
  belongs_to :user, class_name: Reader

  after_create :calculating

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

  def calculating
    recognize = recognize_result.split(/[\s|,|.]/)
    matches = self.talk_topic.content.split(/[\s|,|.]/).map do |word|
      word = ', ' if word == ''
      recognize.include?(word) ? [word,1] : [word, 0]
    end
    m1 = matches.select{|m| m[1] == 0}.size
    score = 100 - ((m1 * 100 / matches.size) / 100.00 * 100)
    self.score = score
    self.matches = matches
    self.save
  end


end
