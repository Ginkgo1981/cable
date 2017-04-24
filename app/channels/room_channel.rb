class RoomChannel < ApplicationCable::Channel
  periodically -> { ping }, every:8
  def subscribed
    # stream_from "messages"
    # stream_from "messages:#{current_user.id}"
    # stream_from "RoomChannel:#{current_user.id}"
    stream_from "user::#{current_user.id}"
    # stream_for current_user
    @index = 0
    current_user.online
  end


  def speak(data)

    # current_user.messages.create!(content: data['message'], room: params[:room])
    # message = Message.create user_id: current_user.id, content:"xxxxx"

    @index = @index + 1
    ActionCable.server.broadcast("user:#{current_user.id}",
                                 message: {msg: "hello, #{data['message']}  #{current_user.name}",
                                           id: @index,
                                           time_stamp: Time.now.to_i,
                                           marked: false})

    # RoomChannel.broadcast_to(current_user,
    #                         title: "hello, current user! #{current_user.name}",
    #                          body: 'body'
    # )
  end


  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    current_user.offline
  end


  private
  def ping
    json  = $redis.zrange("user::#{current_user.id}",0,0).first
    if json
      pp "[roo-channel] ping json #{json}"
      $redis.zrem("user::#{current_user.id}", json)
      message = JSON.parse(json)
      ActionCable.server.broadcast("user::#{current_user.id}",
                                   message: {msg: message['content'],
                                             id: message['id'],
                                             time_stamp: Time.now.to_i,
                                             marked: false})
    else

      pp '[room-channel] ping json nothing'
    end
    # ActionCable.server.broadcast("user:#{current_user.id}",
    #                              message: {msg: "hello, speperiodically #{current_user.name}, index: #{@index}"})
  end


end
