class ResourcesController < ApplicationController


  def filtered_university_list
    universities =
        if json = $redis.get('university_list')
          JSON.parse(json)
        else
          universities = University.all.map(&:name)
          $redis.set('university_list', JSON(universities))
          universities
        end
    filtered =
        if params[:latitude]
          University.by_distance(:origin => [params[:latitude], params[:longitude]]).limit(10).map(&:name)
        else
          []
        end
    render json: {code: 0, data: {
        universities: universities,
        filtered_universities: filtered
    }}


  end


  def university_list
    res =
        if json = $redis.get('university_list')
          JSON.parse(json)
        else
          cities = University.all.map { |u| u.name }
          $redis.set('university_list', JSON(cities))
          cities
        end
    render json: {code: 0, data: res}
  end



  def city_list
    res =
        if json = $redis.get('city_list')
          JSON.parse(json)
        else
          cities = City.all.map { |u| u.name }
          $redis.set('city_list', JSON(cities))
          cities
        end
    render json: {code: 0, data: res}
  end


  def major_list
    res =
        if json = $redis.get('major_list')
          JSON.parse(json)
        else
          majors = Major.all.map { |u| u.name }
          $redis.set('major_list', JSON(majors))
          majors
        end
    render json: {code: 0, data: res}
  end

  def job_list
    res =
        if json = $redis.get('job_list')
          JSON.parse(json)
        else
          jobs=File.open('features/jobs.txt').read.split /\n/
          $redis.set('major_list', JSON(jobs))
          jobs
        end
    render json: {code: 0, data: res}
  end

  def industry_list
    res = ResumeDicIndustry.all.map(&:format)
    render json: {code: 0, data: res}
  end

  def honor_list
    tips = ResumeDicHonorTip.all.map(&:tips).flatten.map{|r| {content: r}}
    res =  [{name: '全部', list: tips}]
    render json: {code: 0, data: res}
  end


  def skill_list
    res = ResumeDicSkill.all.map(&:name)
    render json: {code: 0, data: res}
  end


  def experience_title_list
    res = ResumeDicExperience.all.select{|r| r.name =~ /xx/}.map(&:name)
    render json: {code: 0, data:res}
  end





  end
