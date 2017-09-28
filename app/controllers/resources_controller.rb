class ResourcesController < ApplicationController

  def university_list
    universities = University.all.map(&:name)
    filtered = params[:latitude] ? University.by_distance(:origin => [params[:latitude], params[:longitude]]).limit(10).map(&:name) : []
    render json: {code: 0, data: {
        list: universities,
        hot_list: filtered
    }}
  end

  def city_list
    cities = City.all.map { |u| u.name }
    render json: {code: 0, data: {
        list: cities,
        hot_list: %w(南京 北京 上海 深圳)
    }}
  end

  def major_list
    majors = Major.all.map { |u| u.name }
    render json: {code: 0, data: {
        list: majors,
        hot_list: %w(计算机 物理 化工 销售)
    }}
  end

  def job_list
    positions = File.open('features/positions.txt').read.split /\n/
    hot_positions = File.open('features/hot-positions.txt').read.split /\n/
    render json: {code: 0, data: {
        list: positions,
        hot_list: hot_positions
    }}
  end

  def industry_list
    industries = ResumeDicIndustry.all.map(&:format)
    render json: {code: 0, data: {
        list: industries,
        hot_list: industries
    }}
  end

  def honor_list
    tips = ResumeDicHonorTip.all.map(&:tips).flatten.map { |r| {content: r} }
    honors = [{name: '全部', list: tips}]
    render json: {code: 0, data: {
        list: honors,
        hot_list: []
    }}
  end


  def skill_list
    skills = ResumeDicSkill.all.map(&:name)
    render json: {code: 0, data: {
        list: skills,
        hot_list: skills
    }}
  end


  def experience_title_list
    experiences = ResumeDicExperience.all.select { |r| r.name =~ /xx/ }.map(&:name)
    render json: {code: 0, data: {
        list: experiences,
        hot_list:experiences
    }}
  end

  # industries skills
  def tags_list
    tags = File.open("features/#{params[:category]}.txt").read.split(/\n/)
    render json: {code: 0, data: { tags: tags }}
  end

end
