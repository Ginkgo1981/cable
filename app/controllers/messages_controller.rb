class MessagesController < ApplicationController

  before_action :find_user!, only: [:message_list, :send_message]

  def message_list
    binding.pry
    messages = @user.identity.messages
    if params[:dsin]
      entity = Bean.find_by_dsin params[:dsin]
      messages = messages.filter_by_entity entity if entity
    end
    render json: messages,
        meta: {code: 0},
        each_serializer: MessageSerializer
  end

  def send_message
    binding.pry
    p = {
        student_id: params[:student_id],
        teacher_id: params[:teacher_id],
        university_id: params[:university_id],
        type: params[:type] || 'PointMessage',
        content: params[:content],
        direction: params[:direction] || 'up',
    }
    @user.identity.messages.create! p
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

  private
  def find_user!
    entity = Bean.find_by_dsin params[:dsin]
    @user = entity.user
  end
end


