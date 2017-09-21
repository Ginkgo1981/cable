# == Schema Information
#
# Table name: messages
#
#  id          :uuid             not null, primary key
#  content     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  type        :string
#  expired_at  :datetime
#  state       :integer
#  img_url     :string
#  receiver_id :uuid
#  sender_id   :uuid
#

class MessagesController < ApplicationController

  before_action :find_user_by_token!, only: [:message_list, :batch_send_messages, :send_point_message, :send_notification_message]
  def notification_message_list
    # messages = @user.identity.messages.preload([student: :user], [student: :bean], [university: :bean], [teacher: :bean], :bean).reverse_order
    messages = NotificationMessage.all
    # if params[:dsin].present?
    #   entity = Bean.find_by_dsin params[:dsin]
    #   messages = messages.filter_by_entity entity if entity
    # end
    render json: messages,
           meta: {code: 0},
           each_serializer: MessageSerializer,
           root: "messages"
  end


  #for admin backend
  def batch_send_messages
    params[:student_dsins].each do |student_dsins|
      student = Bean.find_by_dsin student_dsins
      message = @university.point_messages.create! content: params[:content], student: student
      attachments = params[:attachment_dsins].map { |dsin| Bean.find_by_dsin(dsin) }
      message.set_attachments(attachments)
      #send_to_redis
      message.reload.send_to_redis
    end
    render json: {code: 0, msg: 'succ'}
  end

  #for mini-app
  def send_point_message
    raise CableException::NotAllowedSendPointMessage unless @user.allow_send_point_message?
    to = Bean.find_by_dsin params[:dsin]
    message =
        if @student
          @student.point_messages.create! content: params[:content],
                                          university: to,
                                          direction: 'teacher'
        elsif @teacher
          @teacher.point_messages.create! content: params[:content],
                                          student: to,
                                          university: @university,
                                          direction: 'student'
        end

    if params[:photo_key]
      p = Photo.create! key: params[:photo_key]
      message.attached_photos << p
    end
    #send_to_redis
    message.reload.send_to_redis

    if params[:formId]
      @user.forms.create! form_id: params[:formId], from: 'ask_message'
    end
    render json: {code: 0, message: {msg: message.reload.format_for_redis,
                                     time_stamp: Time.now.to_i,
                                     marked: true}
    }
  end

  def send_notification_message
    # raise CableException::NotAllowedSendNotificationMessage unless @user.allow_send_notification_message?
    # message =
    #     if @student && @user.allow_send_notification?
    #       @student.notification_messages.create! content: params[:content],
    #                                       direction: 'teacher'
    #     elsif @teacher && @user.allow_send_notification?
    #       @teacher.notification_messages.create! content: params[:content],
    #                                       university: @university,
    #                                       direction: 'student'
    #     end
    #
    # if params[:photo_key]
    #   p = Photo.create! key: params[:photo_key]
    #   message.attached_photos << p
    # end
    #
    # #send_to_redis
    # message.reload.send_to_redis
    #
    # if params[:formId]
    #   @user.forms.create! form_id: params[:formId], from: 'send_notification_message'
    # end
    # render json: {code: 0, message: {msg: message.reload.format_for_redis,
    #                                  time_stamp: Time.now.to_i,
    #                                  marked: true}
    # }
    message = NotificationMessage.create! content: params[:content]
    attachments = params[:attachment_ids].map { |h|  h[:type].constantize.find_by id: h[:id] }
    message.add_attachments(attachments)
    #send_to_redis
    message.reload.send_to_redis


  end

  def send_subscription_message
    raise CableException::NotAllowedSendSubscriptionMessage unless @user.allow_send_subscription_message?
  end

end


