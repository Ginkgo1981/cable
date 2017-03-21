class UniversitiesController < ApplicationController


  def list
    universities = University.limit(30).map{|u| u.format_brief}
    render json: {
        code: 0,
        data: universities
    }
  end

  def show
    university = University.find_by id: params[:id]
    render json: {
        code: 0,
        data: university.format_detail}
  end

end
