class UniversitiesController < ApplicationController
  before_action :find_user_by_token!, only: [:major_list]
  before_action :find_entity_by_dsin!, only: [:show]


  # def show
  #   render json: @entity,
  #          serializer: UniversitySerializer,
  #          meta: {code: 0},
  #          include_user: true,
  #          include_tags: true
  # end

  # def university_list
  #   universities = University.includes(:bean).where(province: '江苏')
  #   render json: universities,
  #          meta: {code: 0},
  #          each_serializer: UniversitySerializer
  # end

  def university_dsin_list
    res =
      if json = $redis.get('university_dsin_list')
        JSON.parse(json)
      else
        universities = University.where(hot: 1).map {|u| {name: u.name, dsin: u.dsin}}
        $redis.set('university_dsin_list', JSON(universities))
        universities
      end
    render json: {code: 0, data: res}
  end

  def city_dsin_list
    res =
        if json = $redis.get('city_dsin_list')
          JSON.parse(json)
        else
          cities = City.all.map {|u| {name: u.name, dsin: u.dsin}}
          $redis.set('city_dsin_list', JSON(cities))
          cities
        end
    render json: {code: 0, data: res}
  end

  def major_dsin_list
    res =
        if json = $redis.get('major_dsin_list')
          JSON.parse(json)
        else
          majors = MajorHot.all.map {|u| {name: u.name, dsin: u.dsin}}
          $redis.set('major_dsin_list', JSON(majors))
          majors
        end
    render json: {code: 0, data: res}
  end
  def major_list
    university = University.find_by_dsin params[:dsin]
    majors = university.majors.preload(:bean)
    render json: majors,
           meta: {code: 0},
           each_serializer: MajorSerializer,
           include_brief: true
  end

  def create_major
    teacher = @user.identity
    university = teacher.university
    university.majors.create! name: params[:name],
                              content: params[:content]
    render json: {code: 0, message: 'succ'}
  end

end
