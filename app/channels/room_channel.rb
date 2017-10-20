class RoomChannel < ApplicationCable::Channel
  periodically -> { ping }, every: 10

  def subscribed
    # stream_from "messages"
    # stream_from "messages:#{current_user.id}"
    # stream_from "RoomChannel:#{current_user.id}"
    # stream_from "student::#{current_user.id}"
    stream_for current_user
    @index = 0
    current_user.online
  end


  def university_action(data)


    key = "#{Time.now.strftime('%Y%m%d')}-#{data['message']}"
    unless $redis_jobs.exists key


      res_job = Job.search \
            query: {
          bool: {
              must: [
                  {match_phrase: {'job_origin_web_site_name' => data['message']}}

              ]
          }
      }
      jobs = res_job.records.preload(:company).map { |a| a.format.symbolize_keys.merge({type: a.class.name.downcase}) }
      $redis_jobs.set key, JSON(jobs)
    end

    message = PointMessage.reply data['message'], current_user.id
    message[:jobs_redis_key] = key
    RoomChannel.broadcast_to(current_user,
                             message: {msg: message,
                                       time_stamp: Time.now.to_i,
                                       marked: true})
    # message = PointMessage.university data['message'], current_user.id
    # RoomChannel.broadcast_to(current_user,
    #                          message: {msg: message,
    #                                    time_stamp: Time.now.to_i,
    #                                    marked: true})
  end

  def speak(data)
    key = "#{Time.now.strftime('%Y%m%d')}-#{data['message']}"
    unless $redis_jobs.exists key
      jobs = Job.search(data['message']).records.preload(:company).map { |a| a.format.symbolize_keys.merge({type: a.class.name.downcase}) }
      $redis_jobs.set key, JSON(jobs)
    end
    message = PointMessage.reply data['message'], current_user.id
    message[:jobs_redis_key] = key
    RoomChannel.broadcast_to(current_user,
                             message: {msg: message,
                                       time_stamp: Time.now.to_i,
                                       marked: true})
    # @index = @index + 1
    # ActionCable.server.broadcast("student:#{current_user.id}",
    #                              message: {msg: "hello, #{data['message']}  #{current_user.name}",
    #                                        id: @index,
    #                                        time_stamp: Time.now.to_i,
    #                                        marked: false})
    # if data['message'] == 'start-pull'

    # message = NotificationMessage.last
    # RoomChannel.broadcast_to(current_user,
    #                          message: {msg: message.format_for_redis,
    #                                    time_stamp: Time.now.to_i,
    #                                    marked: true})


    # end
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
    json = $redis_cable.zrange("user::#{current_user.id}", 0, 0).first
    message =
        if json
          pp "[room-channel] ping json #{json}"
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
