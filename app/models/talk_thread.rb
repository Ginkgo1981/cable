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
#  retry_count      :integer          default(0)
#

class TalkThread < ApplicationRecord
  belongs_to :talk_topic
  belongs_to :user, class_name: Reader

  before_save :calculating


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
    recognize = recognize_result.split(/[\s|,|.]/).map(&:downcase)
    matches = self.talk_topic.content.split(/[\s|,|.|!|…]/).map(&:downcase).select{|c| c.present?}.map do |word|
      word = ', ' if word == ''
      recognize.include?(word.downcase) ? [word,1] : [word, 0]
    end
    m1 = matches.select{|m| m[1] == 0}.size
    score = 100 - ((m1 * 100 / matches.size) / 100.00 * 100)
    self.score = score
    self.matches = matches
  end


end
