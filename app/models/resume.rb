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

  def format_for_redis
    if Rails.env.production? && (json = $redis.get(self.id))
      JSON.parse(json)
    else
      $redis.set(self.id, JSON(format))
      format
    end
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
        honors: self.honors.map(&:format)
    }
  end
end
