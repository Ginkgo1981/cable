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


    if data['message'] == 'start-pull'

      message = NotificationMessage.last
      RoomChannel.broadcast_to(current_user,
                               message: {msg: message.format_for_redis,
                                         display: 'verify-university',
                                         time_stamp: Time.now.to_i,
                                         marked: true})


    end
    # json = $redis.zrange("user::#{current_user.id}", 0, 0).first
    # if json
    #   pp "[room-channel] speak json: #{json}"
    #   $redis.zrem("student::#{current_user.id}", json)
    #   message = JSON.parse(json)
    #   RoomChannel.broadcast_to(current_user,
    #                            message: {msg: message,
    #                                      display: 'message',
    #                                      time_stamp: Time.now.to_i,
    #                                      marked: false})
    # else
    #   pp "[room-channel] speak json"
    # end
  end


  def unsubscribed
    current_user.offline
  end


  private
  def ping
    json = $redis.zrange("user::#{current_user.id}", 0, 0).first
    if json
      pp "[roo-channel] ping json #{json}"
      $redis.zrem("user::#{current_user.id}", json)
      message = JSON.parse(json)
      RoomChannel.broadcast_to(current_user,
                               message: {msg: message,
                                         time_stamp: Time.now.to_i,
                                         marked: false})
    else
      pp '[room-channel] ping json'
    end
  end


end
