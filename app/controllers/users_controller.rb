class UsersController < ApplicationController

  before_action :find_user_by_token!, only: [:student_list]

  def student_list
    students = Student.includes(:user, :bean, {tags: :bean}).limit(30).reverse_order
    render json: students,
           meta: {code: 0},
           each_serializer: StudentSerializer,
           include_user: true
  end


end
