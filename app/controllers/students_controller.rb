class StudentsController < ApplicationController

  # before_action :find_user_by_token!, only: [:student_list]
  # before_action :find_entity_by_dsin!, only: [:student_list]
  #
  # def student_list
  #   #设计成 @entity.students加以限制,并参entity的权限与 token相比
  #   # students = Student.includes(:user, :bean, {tags: :bean}).limit(30).reverse_order
  #   students = @entity.followed_by_students.preload(:user, :bean, {tags: :bean}).reverse_order
  #   render json: students,
  #          meta: {code: 0},
  #          each_serializer: StudentSerializer,
  #          include_user: true
  # end

end
