class MessagesController < ApplicationController


  def list
    messages = Message.with_type(params[:type]).limit(100).reverse_order.map { |msg| msg.format_for_redis }
    render json: {
        code: 0,
        data: messages
    }
  end

  def send_message
    message = params[:message_type].constantize.create! user_id: params[:sender_id],
                                   content: params[:content],
                                   receiver_id: params[:receiver_id],
                                   attachment_id: params[:attachment_id],
                                   attachment_type: params[:attachment_type]

    render json: {
        code: 0,
        message: 'send ok'
    }
  end



  def load_options
    options = {
        Story: [
            {value:1, name: 't1'},
            {value:2, name: 't2'},
            {value:3, name: 't3'},
            {value:4, name: 't4'}
        ],
        University: [
            {value: 1, name: '南京大学'},
            {value: 2, name: '南京林业大学'},
            {value: 3, name: '南京工业大学'}
        ]
    }

    render json: {
        code: 0,
        data: options
    }
  end


end


