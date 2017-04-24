class UsersController < ApplicationController


  def student_list
    students = Student.includes(:user, :bean, {tags: :bean}).limit(30).reverse_order
    render json: students,
           meta: {code: 0},
           each_serializer: StudentSerializer,
           include_user: true
  end


end
