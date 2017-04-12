class UniversitiesController < ApplicationController


  def list
    universities = University.includes(:bean).limit(30)
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

end
