# == Schema Information
#
# Table name: resumes
#
#  id            :uuid             not null, primary key
#  job_intention :string
#  job_cities    :string
#  job_kind      :string
#  job_title     :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  university    :string
#  major         :string
#  user_id       :uuid
#

class Resume < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  belongs_to :student, foreign_key: :user_id
  has_many :educations
  has_many :experiences
  has_many :skills
  has_many :honors

  has_many :user_jobs
  has_many :jobs, through: :user_jobs
  has_many :companies, through: :companies
  has_one  :qr_code, as: :codeable

  after_create :generate_qrcode

  def as_indexed_json(options={})
    self.format.as_json
  end

  settings index: {number_of_shards: 3, number_of_replicas: 1} do
    mappings do
      indexes :job_intention, type: :string, analyzer: 'ik_smart'
      indexes :job_cities, type: :string, analyzer: 'ik_smart'
      indexes :job_kind, type: :string, analyzer: 'ik_smart'
      indexes :job_title, type: :string, analyzer: 'ik_smart'

      indexes 'educations.university', type: :string, analyzer: 'ik_smart'
      indexes 'educations.major', type: :string, analyzer: 'ik_smart'
      indexes 'educations.degree', type: :string, analyzer: 'ik_smart'
      indexes 'educations.images', type: :string
      indexes 'educations.start_date', type: :date
      indexes 'educations.end_date', type: :date

      indexes 'educations.title', type: :string, analyzer: 'ik_smart'
      indexes 'educations.content', type: :string, analyzer: 'ik_smart'
      indexes 'educations.images', type: :string
      indexes 'educations.start_date', type: :date
      indexes 'educations.end_date', type: :date

      indexes 'skills.title', type: :string, analyzer: 'ik_smart'
      indexes 'skills.content', type: :string, analyzer: 'ik_smart'
      indexes 'skills.category', type: :string, analyzer: 'ik_smart'
      indexes 'skills.images', type: :string

      indexes 'honors.title', type: :string, analyzer: 'ik_smart'
      indexes 'honors.content', type: :string, analyzer: 'ik_smart'
      indexes 'honors.start_date', type: :date
      indexes 'honors.end_date', type: :date
    end
  end

  def score
    educations_score = self.educations.size == 0 ? 0 : (2 + self.educations.size * 0.5)
    experiences_score = self.experiences.size == 0 ? 0 : (2 + self.experiences.size * 0.5)
    skills_score = self.skills.size == 0 ? 0 : (1 + self.skills.size * 0.5)
    honors_score = self.honors.size == 0 ? 0 : (1 + self.honors.size * 0.5)
    score = ((educations_score + experiences_score + skills_score + honors_score) / 10.0) * 100
    score >= 100 ? 100 : score.to_i
  end

  def format_for_redis
    # if Rails.env.production? && (json = $redis.get(self.id))
    #   JSON.parse(json)
    # else
    #   $redis.set(self.id, JSON(format))
    #   format
    # end
    format
  end

  def format
    {
        id: self.id,
        job_intention: self.job_intention,
        job_cities: self.job_cities,
        job_kind: self.job_kind,
        job_title: self.job_title,
        educations: self.educations.map(&:format),
        experiences: self.experiences.map(&:format),
        skills: self.skills.map(&:format),
        honors: self.honors.map(&:format),
        student: self.student.format,
        score: self.score,
        qr_code: self.qr_code.image.path,
        university: self.university,
        major: self.major
    }
  end

  def format_for_email
    {
        university: self.university,
        major: self.major,
        name: self.student.name || self.student.nickname,
        qr_code: "https://images.gaokao2017.cn/#{self.qr_code.image.path}"
    }

  end

  def generate_qrcode
    QrCode.create_from self
  end
end
