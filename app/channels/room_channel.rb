class RoomChannel < ApplicationCable::Channel
  periodically -> { ping }, every:10
  def subscribed
    # stream_from "messages"
    # stream_from "messages:#{current_user.id}"
    # stream_from "RoomChannel:#{current_user.id}"
    # stream_from "student::#{current_user.id}"
    stream_for current_user
    @index = 0
    current_user.online
  end

  def speak(data)
    # @index = @index + 1
    # ActionCable.server.broadcast("student:#{current_user.id}",
    #                              message: {msg: "hello, #{data['message']}  #{current_user.name}",
    #                                        id: @index,
    #                                        time_stamp: Time.now.to_i,
    #                                        marked: false})

    json = $redis.zrange("student::#{current_user.id}", 0, 0).first
    if json
      pp "[room-channel] speak json: #{json}"
      $redis.zrem("student::#{current_user.id}", json)
      message = JSON.parse(json)
      RoomChannel.broadcast_to(current_user,
                               message: {msg: message,
                                         time_stamp: Time.now.to_i,
                                         marked: false})
    else
      pp "[room-channel] speak json: nothing"
    end
  end


  def unsubscribed
    current_user.offline
  end


  private
  def ping
    json = $redis.zrange("student::#{current_user.id}", 0, 0).first
    if json
      pp "[roo-channel] ping json #{json}"
      $redis.zrem("student::#{current_user.id}", json)
      message = JSON.parse(json)
      RoomChannel.broadcast_to(current_user,
                               message: {msg: message,

      pp '[room-channel] ping json nothing'
    end                    time_stamp: Time.now.to_i,
        marked: false})
  else
  end


end
