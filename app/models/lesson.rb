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

  # lesson = Lesson.find '0a11e1a7-c1cd-4808-8b07-d0348bf83de2'
  default_scope -> {order('reading_day')}

  def terms
    self.lesson_lyrics.map do |lyric|
      lyric.en.split(' ').map do |t|
        term = Term.find_by word: t.strip.downcase.singularize
        term.present? ? [t, 1]  : [t, 0]
      end
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
    book = Book.find 'cb79e72b-00fe-4965-b3b4-0c08680ed1e9'


    ###### 01 ######

    file_path = '/home/deploy/apps/cable/lyrics/label1112.txt'
    lesson = book.lessons.where(reading_day:10).first
    lesson.previous= '今天是原版书中的11章12章合并，小王子拜访了一个爱虚荣的人和一个酒鬼，他们又发生了什么呢？'
    lesson.audio_url= 'http://audios.gaokao2017.cn/audio-the-little-prince-05.mp3'
    lesson.word_count= 457
    lesson.save!


    #导入标注
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
    t_file_path = '/home/deploy/apps/cable/translations/version1112.txt'
    File.open(t_file_path, 'r') do |f|
      f.each_line.with_index do |line, idx|
        lesson_lyric = lesson.lesson_lyrics.where(ord: idx).first
        lesson_lyric.sc = line.strip
        lesson_lyric.save
      end
    end


    #图片

    lesson_lyric = book.lessons[1].lesson_lyrics.find_by(ord: 30)
    lesson_lyric.pic = 'https://images.gaokao2017.cn/illustration0204.jpg'
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
