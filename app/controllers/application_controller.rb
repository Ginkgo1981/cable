class ApplicationController < ActionController::API

  rescue_from CableException, with: :render_error

  private
  def find_user_by_token!
    @user = User.find_by! token: request.env['HTTP_TOKEN']
    @hr =  @user if @user.is_a? HumanResource
    @student = @user if @user.is_a? Student
    # @teacher = @identity if @identity.is_a? Teacher
    # @student = @identity if @identity.is_a? Student
    # @university = @teacher.university if @teacher
  end

  # def find_entity_by_dsin!
  #   dsin = params[:dsin]
  #   @entity = Bean.find_by_dsin dsin
  # end


  def render_error(error)
    render json: {code: error.code, msg: error.message.to_s}
  end


  def check_permission! user, source

    #todo
    # @user @entity

    true
  end
end
