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
  def self.create_from_mint_reader(file_path=nil)

    Book.destroy_all
    Lesson.destroy_all

    UserLesson.destroy_all
    UserBook.destroy_all

    %w(
    1102 1103 1104 1105 1106 1107 1108 1109 1110 1111 1112
    1113 1114 1115 1116 1117 1118 1119 1120 1121 1122 1123
    1124 1125 1126 1127 1128 1129 1130 1201 1202 1203 1204
    1205 1206 1207 1208 1209 1210 1211 1212 1213 1214 1215
    1216 1217 1218 1219 1220 1221 1222 1223 1224
    ).each do |date|
      file_path = "/Users/chenjian/Desktop/mintReading/day-#{date}.json"
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
          lyrics = lyric.map {|a,b| arr = [a];  arr << b[0]; arr << b[1]}


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
                                        reading_day:Lesson.maximum(:reading_day).to_i + 1
          questions = json['problem_info']
          questions.each do |q|
            lesson.lesson_questions.create question: q['question']['en'],
                                           options:  q['options'].map{|o| o['en']},
                                           answer: q['answer'][0],
                                           analysis: q['analysis'][0]
          end
        end
      end



    end


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
        questions: self.lesson_questions.map{|q| q.format},
        share_words: share_words,
        share_img_url: share_img_url,
        share_title: share_title,
        teacher_notes_url: teacher_notes_url,
        word_count: word_count
    }
  end
end
