class RoomChannel < ApplicationCable::Channel
  periodically -> { ping }, every: 10

  def subscribed
    # stream_from "messages"
    # stream_from "messages:#{current_user.id}"
    # stream_from "RoomChannel:#{current_user.id}"
    # stream_from "student::#{current_user.id}"
    stream_for current_user
    @index = 0
    # current_user.online
  end


  def university_action(data)
    key = "#{Time.now.strftime('%Y%m%d')}-#{data['message']}"
    unless $redis_jobs.exists key
      jobs = Job.search_by_site_name(data['message']).records.preload(:company).map { |a| a.format.symbolize_keys.merge({type: a.class.name.downcase}) }
      $redis_jobs.set key, JSON(jobs)
    end
    message = PointMessage.reply data['message'], current_user.id
    message[:jobs_redis_key] = key
    RoomChannel.broadcast_to(current_user,
                             message: {msg: message,
                                       time_stamp: Time.now.to_i,
                                       marked: true})
  end

  def speak(data)
    key = "#{Time.now.strftime('%Y%m%d')}-#{data['message']}"
    SlackSendJob.perform_later("[cable] search #{current_user.nickname} #{key}")
    unless $redis_jobs.exists key
      jobs = Job.search_by_query(data['message']).records.preload(:company).map { |a| a.format.symbolize_keys.merge({type: a.class.name.downcase}) }
      $redis_jobs.set key, JSON(jobs)
    end
    message = PointMessage.reply data['message'], current_user.id
    message[:jobs_redis_key] = key
    RoomChannel.broadcast_to(current_user,
                             message: {msg: message,
                                       time_stamp: Time.now.to_i,
                                       marked: true,
                                       readed: true})
    # @index = @index + 1
    # ActionCable.server.broadcast("student:#{current_user.id}",
    #                              message: {msg: "hello, #{data['message']}  #{current_user.name}",
    #                                        id: @index,
    #                                        time_stamp: Time.now.to_i,
    #                                        marked: false})
  end


  def unsubscribed
    # current_user.offline
  end

  private
  def ping
    json = $redis_cable.zrange("user::#{current_user.id}", 0, 0).first
    message =
        if json
          # pp "[room-channel] ping json #{json}"
          $redis_cable.zrem("user::#{current_user.id}", json)
          JSON.parse(json)
        else
          current_user.next_notification_message
        end

    if message
      puts "[room-channal] ping #{message}"
      RoomChannel.broadcast_to(current_user,
                               message: {msg: message,
                                         time_stamp: Time.now.to_i,
                                         marked: false})
    end
  end


end
