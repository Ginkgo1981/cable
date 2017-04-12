class CableException < Exception
  attr_reader :code

  class TeacherNotFound < CableException
    def initialize(msg = nil)
      msg ||= 'The code submitted is not a valid one.'
      super
      @code = 1000
    end
  end

  class CellCodeError < CableException
    def initialize(msg = nil)
      msg ||= '验证码不对'
      super
      @code = 1001
    end
  end


end
