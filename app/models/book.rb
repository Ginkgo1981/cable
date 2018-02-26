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


  def mock
    Book.create! book_name: 'the story of my life',
                 book_name_cn: '假如给我三天光明',
                 book_cover_img_url: 'https://images.gaokao2017.cn/banner-2018-02-25.png'
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
