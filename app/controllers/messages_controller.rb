class MessagesController < ApplicationController


  def list
    messages = Message.limit(10).map{|msg| msg.format_for_redis}
    render json: {
        code: 0,
        data: messages
    }
  end

  def send_point_message
    message = PointMessage.create! user_id: 50,
                                   content: params[:message],
                                   receiver_id: params[:receiver_id],
                                   attachment_id: params[:attachment_id],
                                   attachment_type: params[:attachment_type]

    render json: {
        code: 0,
        message: 'send ok'
    }

  end


  def show


  end
end
