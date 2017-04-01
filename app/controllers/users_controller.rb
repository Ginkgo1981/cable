class UsersController < ApplicationController

  def register
    user = User.find_by cell: params[:cell]
    if user && params[:sms_auth_code] == user.sms_auth_code
      user.register_status = true
      user.register_at = Time.now
      user.name = params[:name]
      user.save register_status: true,
                register_at: Time.now,
                name: params[:name]

      if params[:identity_type] == 'Student'
        Student.create! province: params[:province],
                        city: params[:city],
                        school: params[:school],
                        user: user

      elsif params[:identity_type] == 'Teacher'

      elsif params[:identity_type] == 'Stuff'

      end
    end
    render json: {
        code: 0,
        message: '创建用户成功',
        data: {user: user.format}
    }
  end

  def send_sms_auth_code
    user = User.find_by cell: params[:cell]
    unless user
      user = User.create! :cell => params[:cell], register_status: false
      #todo send sms
      render json: {
          code: 0,
          message: '验证码发送成功'}
    end
  end


  def student_list
    students = Student.includes(:user, :bean).limit(30).reverse_order
    render json: students,
           meta: {code: 0},
           each_serializer: StudentSerializer,
           include_user: true
           #adapter: :json_api,
  end




  def student_detail

    student = Student.includes(:user, :bean).find_by dsin: params[:dsin]


  end

  def user_detail
    user = User.find_by id: params[:user_id]
    render json: {
        code: 0,
        data: {user: user.format}
    }
  end


end
