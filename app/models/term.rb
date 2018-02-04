# == Schema Information
#
# Table name: terms
#
#  id            :uuid             not null, primary key
#  word          :string
#  ctype         :string
#  pronounce     :string
#  audio_origin  :string
#  audio_url     :string
#  level         :string
#  definition_en :string
#  definition_cn :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Term < ApplicationRecord
  has_many :sentances, dependent: :destroy


  #add cache later
  def self.get_translation(word)
    term = Term.find_by word: word.strip.downcase.singularize.gsub(/[^0-9A-Za-z]/, '')
    term.format
  end


  def format
    {
        word: word,
        ctype: ctype,
        pronounce: pronounce,
        audio_url: audio_url,
        level: level,
        definition_en: definition_en,
        definition_cn: definition_cn,
        sentances: self.sentances.first(3).map(&:format)
    }
  end

end
