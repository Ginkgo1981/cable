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

class LessonLyric < ApplicationRecord
  belongs_to :lesson
  default_scope { order(:ord) }

  def format
    {
        ord: self.ord,
        sec: self.sec,
        en: self.en.strip,
        sc: self.sc || '',
        css: self.css || '',
        pic: self.pic || ''
    }
  end







end
