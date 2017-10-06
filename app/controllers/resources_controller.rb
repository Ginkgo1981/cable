class ResourcesController < ApplicationController

  def university_list
    # universities = University.all.map(&:name)
    universities = JSON.parse($redis_cable.get('libs:universities'))
    render json: {code: 0, data: {
        list: universities,
        hot_list: %w(南京大学 东南大学 南京理工大学)
    }}
  end

  def university_filter_by_geo
    filtered = params[:latitude] ? University.by_distance(:origin => [params[:latitude], params[:longitude]]).limit(10).map(&:name) : []
    render json: {code: 0, data: {
        list: filtered,
    }}

  end

  def city_list
    # cities = City.all.map { |u| u.name }
    cities = JSON.parse($redis_cable.get('libs:cities'))
    render json: {code: 0, data: {
        list: cities,
        hot_list: %w(南京 北京 上海 深圳)
    }}
  end

  def major_list
    # majors = Major.all.map { |u| u.name }
    majors = JSON.parse($redis_cable.get('libs:majors'))
    render json: {code: 0, data: {
        list: majors,
        hot_list: %w(计算机 物理 化工 销售)
    }}
  end

  def job_list
    # positions = File.open('features/positions.txt').read.split /\n/
    # hot_positions = File.open('features/hot_positions.txt').read.split /\n/
    positions = JSON.parse($redis_cable.get('libs:positions'))
    hot_positions = JSON.parse($redis_cable.get('libs:hot_positions'))
    render json: {code: 0, data: {
        list: positions,
        hot_list: hot_positions
    }}
  end

  def industry_list
    # industries = ResumeDicIndustry.all.map(&:format)
    industries = JSON.parse($redis_cable.get('libs:industries'))
    render json: {code: 0, data: {
        list: industries,
        hot_list: industries
    }}
  end



  def honor_list
    # tips = ResumeDicHonorTip.all.map(&:tips).flatten.map { |r| {content: r} }
    tips = JSON.parse($redis_cable.get('libs:tips'))
    honors = [{name: '全部', list: tips}]
    render json: {code: 0, data: {
        list: honors,
        hot_list: []
    }}
  end


  def skill_list
    # skills = ResumeDicSkill.all.map(&:name)
    skills = JSON.parse($redis_cable.get('libs:skills'))
    render json: {code: 0, data: {
        list: skills,
        hot_list: skills
    }}
  end


  def experience_title_list
    # experiences = ResumeDicExperience.all.select { |r| r.name =~ /xx/ }.map(&:name)
    experiences = JSON.parse($redis_cable.get('libs:experiences'))
    render json: {code: 0, data: {
        list: experiences,
        hot_list:experiences
    }}
  end

  # industries skills
  def tags_list
    # industries_tag_list = File.open('features/industries_tag_list.txt').read.split(/\n/)
    # skills_tag_list = File.open('features/skills_tag_list.txt').read.split(/\n/)
    industries_tag_list = JSON.parse($redis_cable.get('libs:industries_tag_list'))
    skills_tag_list = JSON.parse($redis_cable.get('libs:skills_tag_list'))

    render json: {code: 0, data: { industries_tag_list: industries_tag_list,
                                   skills_tag_list: skills_tag_list}}
  end

end
