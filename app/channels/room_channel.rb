class RoomChannel < ApplicationCable::Channel
  periodically -> { ping }, every:5
  def subscribed
    # stream_from "messages"
    # stream_from "messages:#{current_user.id}"
    # stream_from "RoomChannel:#{current_user.id}"
    stream_from "user:#{current_user.id}"
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

    $redis.cache('wechat_access_token', 'ssssssss', 2*60*60)



    #
    # ActionCable.server.broadcast("user:#{current_user.id}",
    #                              message: {msg: "hello,   #{current_user.name}",
    #                                        id: @index,
    #                                        time_stamp: Time.now.to_i,
    #                                        marked: false})

    # User.create name: "sssssss"
    # pp "===== ping current_user #{current_user.id}======="
    #
    # if(current_user.id == 1)
    #   pp "=******* ping current_user #{current_user.id}======="
    #   sleep 3
    # end
    # @index = @index +1
    # ActionCable.server.broadcast("user:#{current_user.id}",
    #                              message: {msg: "hello, speperiodically #{current_user.name}, index: #{@index}"})
  end


end
