# == Schema Information
#
# Table name: lessons
#
#  id                :uuid             not null, primary key
#  book_id           :uuid
#  title_cn          :string
#  title_en          :string
#  previous          :string
#  audio_url         :string
#  audio_name        :string
#  lyric             :text             is an Array
#  share_words       :text
#  share_img_url     :string
#  share_title       :string
#  teacher_notes_url :string
#  word_count        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  reading_day       :integer          default(0)
#  reading_date      :string
#

class Lesson < ApplicationRecord
  belongs_to :book
  has_many :lesson_questions, dependent: :destroy
  has_many :user_lessons
  has_many :users, through: :user_lessons
  has_many :lesson_words
  has_many :lesson_lyrics

  has_one :user_campaign_progress, as: :bucket_item

  # lesson = Lesson.find '0a11e1a7-c1cd-4808-8b07-d0348bf83de2'
  default_scope -> {order('reading_day')}


  def next
    Lesson.find_by reading_day: self.reading_day + 1,
                  book: self.book
  end


  def ques
    lesson.lesson_questions.create! question: 'How did I learn to speak?',
                                    options: ['keeping one hand on my throat.','listening to the sound.','through spelling'],
                                     answer: 0,
                                    analysis: '原文提到：I used to make noises, keeping one hand on my throat while the other hand felt the movements of my lips. (我常常会发出一些杂音，我会把一只手放在自己的喉咙上出声，而别人则用手感知我嘴唇的移动。)'

    lesson.lesson_questions.create! question: 'Which word can I still remember after I get sick?',
                                    options: [ 'water', 'wawa', 'nothing'],
                                    answer: 0,
                                    analysis: ' There was, however, one word the meaning of which I still remembered, WATER. I pronounced it "wa-wa." (至今我仍然记得学习“water”这个词的过程，一开始，我总是发出“wawa”的声音。)'


   lesson.lesson_questions.create! question: 'What makes me feel upset?',
                                   options: ['Only rely on sign language to communicate with people', "Can't speak", 'I am a blind girl'],
                                   answer: 0,
                                   analysis: ' 原文提到One who is entirely dependent upon the manual alphabet has always a sense of restraint, of narrowness. This feeling began to agitate me with a vexing, forward-reaching sense of a lack that should be filled.(一个完全依赖手写字母来交流的人总会感觉到处处受限。 这种挫折感既令我无比懊恼，又使我进一步意识到，我应该尽快弥补自己的交流缺陷。)                                  '

  end

  def terms
      if json = $redis.get(self.id)
        JSON.parse(json)
      else
        terms = self.lesson_lyrics.map do |lyric|
          {
              sc: lyric.sc,
              terms:
                  lyric.en.split(' ').map do |t|
                    term = Term.find_by word: t.gsub(/[^0-9A-Za-z]/, '').try(:strip).try(:downcase).try(:singularize)
                    if term.present?
                      {t: t, s: 1}
                    else
                      UnknowTerm.create word: t
                      #save to
                      {t: t, s: 0}
                    end
                  end
          }
        end
        $redis.set(self.id, JSON(terms))
        terms
      end
  end


  def self.export_the_little_prince
    book = Book.find 'ccdd79c9-0a93-4f5e-9c70-1803d7fce5e2'
    File.open('the-little-prince-q-a.txt', 'w') do |file|
      book.lessons.each do |lesson|
        file.puts lesson.title_en
        file.puts "前情概要: #{lesson.previous}"
        lesson.lesson_questions.each_with_index do |question,idx|
          file.puts "##{idx + 1} #{question.question}"
          file.puts question.options
          file.puts "答案: #{question.answer.to_i + 1 }"
          file.puts "解析: #{question.analysis}"
        end
        file.puts "==============================="
      end
    end
  end

  def temp_split_to_lyrics
    self.lyric.each_with_index do |l, idx |
      self.lesson_lyrics.create! ord: idx,
                                   sec: l[0],
                                   en: l[1],
                                   css: l[2]
    end


  end

  def self.create_from_loki
    book  = Book.find '9e18725d-885c-4547-af22-e7983208e7a7'



    ###### 01 ######

    # lesson = book.lessons.where(reading_day:1).first

    lesson.destroy

    lesson = book.lessons.create! title_en: 'chapter19-day22',
                        previous: '有时候心灰意冷到了极点，而且还把这种情绪流露出来，至今思念及此，我就惭愧万分',
                        audio_url: 'http://audios.gaokao2017.cn/the-story-of-my-life-audio-chapter19-day22.mp3',
                        reading_day: 22


    #导入标注
    file_path = '/home/deploy/apps/cable/lyrics/the-story-of-my-life-label-chapter19-day22.txt'
    File.open(file_path, 'r') do |f|
      f.each_line.with_index do |line, idx|
        timeReg = /\[(?<min>\d{2}):(?<sec>\d{2}).(?<msec>\d{2})\]/
        m = line.match timeReg
        int_sec = m[:min].to_i * 60 + m[:sec].to_i +  m[:msec].to_i / 100.00
        en = line.sub timeReg, ''
        puts "#{idx} #{int_sec} #{en}"
        lesson.lesson_lyrics.create! ord: idx,
            sec: int_sec,
            en: en.strip
      end
    end


    #翻译
    t_file_path = '/home/deploy/apps/cable/lyrics/the-story-of-my-life-version-chapter19-day22.txt'
    File.open(t_file_path, 'r') do |f|
      f.each_line.with_index do |line, idx|
        lesson_lyric = lesson.lesson_lyrics.where(ord: idx).first
        lesson_lyric.sc = line.strip
        lesson_lyric.save
      end
    end

    #图片
    lesson_lyric = book.lessons.where(reading_day:24).first.lesson_lyrics.find_by(ord: 21)
    lesson_lyric.pic = 'http://audios.gaokao2017.cn/book-the-little-prince-chapter27-day24-01.jpg	'
    lesson_lyric.save
  end



  def self.attach_word_list
    %w(words-1-8 words-9-16 words-17-24).each do |date|
      file_path = "#{Rails.root}/reading-json/#{date}.json"
      File.open(file_path, 'r') do |f|
        f.each_line do |line|
          json = JSON(line)
          json.each do |h|
            puts "=== day #{h['day']}"


            lesson = Lesson.find_by reading_day: h['day']
            if lesson
              h['word_list'].each do |word|
                lesson.lesson_words.create! word: word['word'],
                                            mean: word['mean'],
                                            accent: word['accent'],
                                            level: word['level'],
                                            audio_url: word['audio_url']
              end

            end
          end
        end
      end
    end

  end


  def self.create_from_mint_reader(file_path=nil)
    #
    # Book.destroy_all
    # Lesson.destroy_all
    #
    # UserLesson.destroy_all
    # UserBook.destroy_all

    (1101..1131).each do |date|
      file_path = "#{Rails.root}/reading-json-02/day-#{date}.json"
      File.open(file_path, 'r') do |f|
        f.each_line do |line|
          json = JSON(line)
          title_en = json['article_info']['article_title']
          previous = json['article_info']['previous']
          sentences = json['article_info']['sentences'].map { |s| [s['sentence'], s['type']] }
          time_list = json['article_info']['audio_info']['time_list']
          audio_name = json['article_info']['audio_info']['audio_name']
          audio_url = json['article_info']['audio_info']['audio_url']

          lyric = time_list.zip sentences
          lyrics = lyric.map { |a, b| arr = [a]; arr << b[0]; arr << b[1] }


          share_words = json['article_info']['share_words']
          word_count = json['article_info']['words_count']
          book_cover_img_url = json['book_cover_img_url']
          book_name = json['book_name']
          book_name_cn = json['book_name_cn']
          book_json = {
              book_cover_img_url: book_cover_img_url,
              book_name: book_name,
              book_name_cn: book_name_cn
          }
          book = Book.find_or_create book_json
          lesson = book.lessons.create! previous: previous,
                                        audio_name: audio_name,
                                        audio_url: audio_url,
                                        lyric: lyrics,
                                        title_en: title_en,
                                        share_words: share_words,
                                        word_count: word_count,
                                        reading_day: Lesson.maximum(:reading_day).to_i + 1
          questions = json['problem_info']
          questions.each do |q|
            lesson.lesson_questions.create question: q['question']['en'],
                                           options: q['options'].map { |o| o['en'] },
                                           answer: q['answer'][0],
                                           analysis: q['analysis'][0]
          end
        end
      end


    end


  end





  def replace_audio
    arr = self.audio_url.split /audios\//
    url = "https://images.gaokao2017.cn/audios-01-#{arr[1]}"
    self.audio_url = url
    self.save!
  end

  def format
    {
        id: id,
        book_id: book_id,
        title_cn: title_cn,
        title_en: title_en,
        previous: previous,
        audio_url: audio_url,
        audio_name: audio_name,
        reading_day: reading_day,
        # lyric: lyric,
        lesson_lyrics: lesson_lyrics.map(&:format),
        questions: self.lesson_questions.map { |q| q.format },
        share_words: share_words,
        share_img_url: share_img_url,
        share_title: share_title,
        teacher_notes_url: teacher_notes_url,
        word_count: word_count,
        words: self.lesson_words.map{|lw| lw.format}
    }
  end
end
