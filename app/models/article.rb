# == Schema Information
#
# Table name: articles
#
#  id                :uuid             not null, primary key
#  book_id           :uuid
#  title_cn          :string
#  title_en          :string
#  previous          :string
#  audio_url         :string
#  audio_name        :string
#  lyric             :text             is an Array
#  questions         :hstore           is an Array
#  share_words       :text
#  share_img_url     :string
#  share_title       :string
#  teacher_notes_url :string
#  word_count        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Article < ApplicationRecord
  belongs_to :book

  def self.create_from_mint_reader(file_path=nil)
    file_path = '/Users/chenjian/Desktop/mintReading/day01.json'
    File.open(file_path, 'r') do |f|
      f.each_line do |line|
        json = JSON(line)
        title_en = json['article_info']['article_title']
        previous = json['article_info']['previous']
        sentences = json['article_info']['sentences'].map { |s| s['sentence'] }
        time_list = json['article_info']['audio_info']['time_list']
        audio_name = json['article_info']['audio_info']['audio_name']
        audio_url = json['article_info']['audio_info']['audio_url']
        lyric = time_list.zip sentences
        share_words = json['article_info']['share_words']
        word_count = json['article_info']['words_count']
        # questions = json['problem_info'].map { |s| s.to_json }
        questions = json['problem_info'].to_json
        book_cover_img_url = json['book_cover_img_url']
        book_name = json['book_name']
        book_name_cn = json['book_name_cn']
        book_json = {
            book_cover_img_url: book_cover_img_url,
            book_name: book_name,
            book_name_cn: book_name_cn
        }
        book = Book.find_or_create book_json
        book.articles.create previous: previous,
                             audio_name: audio_name,
                             audio_url: audio_url,
                             lyric: lyric,
                             title_en: title_en,
                             share_words: share_words,
                             word_count: word_count,
                             questions: questions
      end
    end

  end

  def questions_hash
    self.questions.map { |q| JSON(q) }
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
        lyric: lyric,
        questions: questions_hash,
        share_words: share_words,
        share_img_url: share_img_url,
        share_title: share_title,
        teacher_notes_url: teacher_notes_url,
        word_count: word_count
    }

  end

end
