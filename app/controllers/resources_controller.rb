class ResourcesController < ApplicationController



  def university_list
    res =
        if json = $redis.get('university_list')
          JSON.parse(json)
        else
          universities = University.all.map(&:name)
          $redis.set('university_list', JSON(universities))
          universities
        end
    render json: {code: 0, data: res}
  end


  def city_list
    res =
        if json = $redis.get('city_list')
          JSON.parse(json)
        else
          cities = City.all.map {|u| u.name }
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
          majors = Major.all.map {|u| u.name}
          $redis.set('major_list', JSON(majors))
          majors
        end
    render json: {code: 0, data: res}
  end
end
