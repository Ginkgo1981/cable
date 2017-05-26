class MessagesController < ApplicationController

  before_action :find_user_by_token!, only: [:message_list, :batch_send_messages, :ask_message]

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

  def ask_message
    university = Bean.find_by_dsin params[:university_dsin]
    message = @student.point_messages.create! content: params[:content],
                                              university: university,
                                              direction: 'up'
    @user.forms.create! form_id: params[:formId], from: 'bind_cell'
    render json: {code: 0, message: {msg: message.format_for_redis,
                                     time_stamp: Time.now.to_i,
                                     marked: true}
    }
  end

end


