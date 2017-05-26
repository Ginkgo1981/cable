class UniversitiesController < ApplicationController
  before_action :find_user_by_token!, only: [:university_list, :major_list]


  def university_list
    universities = University.includes(:bean)
    render json: universities,
           meta: {code: 0},
           each_serializer: UniversitySerializer
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
