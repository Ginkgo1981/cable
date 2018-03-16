# == Schema Information
#
# Table name: books
#
#  id                 :uuid             not null, primary key
#  book_name          :string
#  book_name_cn       :string
#  book_cover_img_url :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Book < ApplicationRecord
  has_many :lessons, dependent: :destroy
  has_many :book_productions, dependent:  :destroy

  has_many :user_books
  has_many :users

  #todo lesson_id 2959f0b9-8634-4cd6-ae9a-86eb526d8145 找出来

  def self.amend

    [
        '0da0ce54-ace2-444b-9741-6f27139acbd7',
        'f113731a-4eab-41ee-888a-3a846be1202b',
        '75bf33ef-88fc-413e-9307-eea35cc4faf3',
        '7485a250-574b-458a-b89b-a9b2f88e1f53',
        'bf8a7cef-94f0-4463-ad7e-cecf48754647',
        '995366a9-ec4f-4a84-917d-adfd144e49fc',
        'a7b6636f-6cdc-4b00-96d8-fafd98d3c3a8',
        '31ef160f-0f37-4e8a-9b2d-ce7434b90d94',
        '4a985c0c-4912-4a36-8139-9c6639e6dd6f'
    ].each do |id|
      book = Book.find id
      book.lessons.each do |lesson|
        lesson_lyric = lesson.lesson_lyrics.where(ord: 1).first
        if lesson_lyric
            lesson.title_cn = lesson_lyric.sc
            lesson.title_en = lesson_lyric.en
            lesson.save!
            lesson_lyric.destroy
        else
          puts "===== wrong  lesson: #{lesson.id}"
        end
      end
    end
  end



  def self.write_to_json

    File.open('fix10_json.txt', 'w') do |file|
      [
          'a84f6b1f-f28e-46c3-b323-a0c3f805afb1',
          '0da0ce54-ace2-444b-9741-6f27139acbd7',
          'f113731a-4eab-41ee-888a-3a846be1202b',
          '75bf33ef-88fc-413e-9307-eea35cc4faf3',
          '7485a250-574b-458a-b89b-a9b2f88e1f53',
          'bf8a7cef-94f0-4463-ad7e-cecf48754647',
          '995366a9-ec4f-4a84-917d-adfd144e49fc',
          'a7b6636f-6cdc-4b00-96d8-fafd98d3c3a8',
          '31ef160f-0f37-4e8a-9b2d-ce7434b90d94',
          '4a985c0c-4912-4a36-8139-9c6639e6dd6f',
      ].each do |id|
        book = Book.find id
        book.lessons.each do |lesson|
          lesson_lyric = lesson.lesson_lyrics.where(ord: 1).first
          file.puts lesson_lyric.to_json
        end
      end
    end

  end

  def self.read_from_json
   File.open('fix10_json.txt', 'r') do |f|
      f.each_line do |line|
        begin
          json = JSON(line)
          lesson = Lesson.find json['lesson_id']
          puts lesson.id
          unless lesson.lesson_lyrics.where(ord:1).first
            lesson.lesson_lyrics.create! ord: json['ord'],
                                         sec: json['sec'],
                                         en: json['en'],
                                         sc: json['sc']
          end
        rescue => e
          puts e.to_s
        end
      end
    end
  end





  def mock
    # a84f6b1f-f28e-46c3-b323-a0c3f805afb1 01-中国文化
    # 0da0ce54-ace2-444b-9741-6f27139acbd7 02-实用口语对话
    # f113731a-4eab-41ee-888a-3a846be1202b 03-户外活动话题
    # 75bf33ef-88fc-413e-9307-eea35cc4faf3 04-日常英文话题
    # 7485a250-574b-458a-b89b-a9b2f88e1f53 05-美食话题
    # bf8a7cef-94f0-4463-ad7e-cecf48754647 06-职场对话
    # 995366a9-ec4f-4a84-917d-adfd144e49fc 07-英语对话中级篇
    # a7b6636f-6cdc-4b00-96d8-fafd98d3c3a8 08-英语对话初级篇
    # 31ef160f-0f37-4e8a-9b2d-ce7434b90d94 09-英语对话高级篇
    # 4a985c0c-4912-4a36-8139-9c6639e6dd6f 10-餐桌对话


    Book.create! book_name: '职场对话',
                 book_name_cn: '职场对话',
                 book_cover_img_url: ''
  end

  def next_bucket_item(p_bucket_item_id)
    p_lesson = self.lessons.find_by p_bucket_item_id
    p_lesson.next
  end

  def first_bucket_item
    self.lessons.first
  end

  def export_to_txt
    File.open("books/#{self.book_name}.txt", 'w') do |f|
      self.lessons.order(:reading_day).each do |lesson|
        f.puts ''
        f.puts ''
        f.puts ''
        f.puts "==========    Day: #{lesson.reading_day}   ========"
        f.puts ''
        f.puts lesson.audio_url
        f.puts ''
        line = ''
        lesson.lyric.each do |l|
          if l[2] == 'con_start'
            f.puts line
            line = l[1]
          else
            line += l[1]
          end
        end
        f.puts line
      end
    end
  end



  def self.find_or_create json
    book = Book.find_by book_name: json[:book_name]
    if book.blank?
      book = Book.create! book_name: json[:book_name],
                   book_name_cn: json[:book_name_cn],
                   book_cover_img_url: json[:book_cover_img_url]

    end
    book
  end

  def format
    {
        id: id,
        book_name:  book_name,
        book_name_cn: book_name_cn,
        book_cover_img_url: book_cover_img_url

    }
  end

  def self.create_productions
    BookProduction.destroy_all
    Book.all.each_with_index do |book, idx|
      puts idx
      duration = book.lessons.size
      sell_start_at = DateTime.new(2018,1,1) + idx.month
      sell_end_at = DateTime.new(2018, 1, 31) + idx.month
      lesson_start_at = Date.new(2018,1,1) + idx.month
      lesson_end_at = lesson_start_at + duration.days
      objectives = [
          "通过#{duration}天的学习, 完整读完一本英语原著",
          "通过#{duration}天的学习, 学到 10K的词汇,其中4级词汇6000个, 其中6级词汇2000个",
          '完整学完课程和完成打卡任务,可以得到一本原著'
      ]
      requirements = %w(本期是实验项目,采用邀请制 你英文水平应该是4级以上)
      book.book_productions.create! title: "天马阅读营第#{idx + 1}期",
                                    lesson_start_at: lesson_start_at,
                                    lesson_end_at: lesson_end_at,
                                    sell_start_at: sell_start_at,
                                    sell_end_at: sell_end_at,
                                    duration: duration,
                                    objectives: objectives,
                                    requirements: requirements
    end
  end


end
