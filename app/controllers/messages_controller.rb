class MessagesController < ApplicationController

  before_action :find_user_by_token!, only: [:message_list, :batch_send_messages, :send_message]

  def message_list
    messages = @user.identity.messages.preload([student: :user], [student: :bean], [university: :bean], [teacher: :bean], :bean).reverse_order
    if params[:dsin].present?
      entity = Bean.find_by_dsin params[:dsin]
      messages = messages.filter_by_entity entity if entity
    end
    render json: messages,
           meta: {code: 0},
           each_serializer: MessageSerializer,
           root: "messages"
  end

  def batch_send_messages
    params[:student_dsins].each do |student_dsins|
      student = Bean.find_by_dsin student_dsins
      message = @university.point_messages.create! content: params[:content], student: student
      attachments = params[:attachment_dsins].map { |dsin| Bean.find_by_dsin(dsin) }
      message.set_attachments(attachments)
      message.reload.send_to_redis
    end
    render json: {code: 0, msg: 'succ'}
  end

  def send_message
    to = Bean.find_by_dsin params[:dsin]

    if @student
      message = @student.point_messages.create! content: params[:content],
                                                university: to,
                                                direction: 'teacher'
    elsif @teacher
      message = @teacher.point_messages.create! content: params[:content],
                                                student: to,
                                                university: @university,
                                                direction: 'student'
    end

    if params[:photo_key]
      p = Photo.create! key: params[:photo_key]
      message.attached_photos << p
    end

    if params[:formId]
      @user.forms.create! form_id: params[:formId], from: 'ask_message'
    end

    render json: {code: 0, message: {msg: message.reload.format_for_redis,
                                     time_stamp: Time.now.to_i,
                                     marked: true}
    }
  end

end


