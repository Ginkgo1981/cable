module ApplicationCable
  class Connection < ActionCable::Connection::Base

    identified_by :current_user


    def connect
      pp "====== connect ====="
      self.current_user = find_verified_user
      logger.add_tags current_user.name
    end

    def disconnect
      # Any cleanup work needed when the cable connection is cut.
    end

    private
    def find_verified_user
      pp '===== find_verified_user ====='
      User.find_by_id(request.params['id']) || reject_unauthorized_connection
    end


  end
end
