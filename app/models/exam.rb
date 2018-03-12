# == Schema Information
#
# Table name: exams
#
#  id         :uuid             not null, primary key
#  title      :string
#  note       :string
#  tag        :text             is an Array
#  level      :integer
#  use_count  :integer
#  state      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Exam < ApplicationRecord
  has_many :user_exams
  has_many :users, through: :user_exams

  has_many :exam_questions,dependent: :destroy

  def self.rand_one
    exam = nil
    loop do
      exam = Exam.find(Exam.pluck(:id).shuffle.first)
      if exam.state != 9
        break
      end
    end
    exam.state = 9
    exam.save!
    exam
  end

  def self.generate_mock_data
    terms = Term.where.not(word: nil).map{|t| {word:t.word,definition_cn: t.definition_cn, level: t.level}}
    (0..1000).each do |i|
      exam = Exam.create! title: "英文选义 #{i}"
      (0..4).each do |idx|
        g = terms.sample(4)
        answer_idx = (0..3).to_a.sample
        term = g[answer_idx]
        exam.exam_questions.create! title: term[:word],
                                    options: g.map{|g| g[:definition_cn]},
                                    answer: answer_idx,
                                    idx: idx
      end
    end
  end


  def format
    {
        id: id,
        title: title,
        exam_questions: self.exam_questions.map(&:format)
    }
  end
end
