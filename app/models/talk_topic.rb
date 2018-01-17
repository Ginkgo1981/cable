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
#  audio_url  :string
#

class TalkTopic < ApplicationRecord

  has_many :talk_threads, dependent: :destroy
  def join_conversation(user, audio_url)

    #同一用户不能参与两次
    self.talk_threads.create! user: user, audio_url: audio_url

  end

  def format
    {
        id: self.id,
        talk_date: self.talk_date,
        banner: self.banner,
        chinese: self.chinese,
        note: self.note,
        content: self.content,
        talk_threads: self.talk_threads.order('score desc').map{|t| t.format}
    }
  end


end
