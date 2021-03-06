module ApplicationCable
  class Connection < ActionCable::Connection::Base

    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      pp "[cable] connect current_user #{self.current_user.id}"
      logger.add_tags current_user.name
    end

    def disconnect
      # Any cleanup work needed when the cable connection is cut.
    end

    private
    def find_verified_user
      pp "[connection-cable] find_verified_user params: #{request.params}"
      User.find_by_token(request.params['token']) || reject_unauthorized_connection
    end


  end
end
