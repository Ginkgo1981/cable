class UniversitiesController < ApplicationController


  def list
    universities = University.includes(:bean).limit(30)
    render json: universities,
           meta: {code: 0},
           each_serializer: UniversitySerializer
  end

  def show
    university = University.find_by id: params[:id]
    render json: {
        code: 0,
        data: university.format_detail}
  end

end
