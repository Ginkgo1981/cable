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

class LessonWord < ApplicationRecord
  belongs_to :lesson
  def format
    {

        lesson_id: lesson_id,
        word: word,
        mean: mean,
        accent: accent,
        level:level,
        audio_url: audio_url
    }
  end


end
