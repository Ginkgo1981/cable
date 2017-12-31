class CableException < RuntimeError
  attr_reader :code


  class DuplicatedLesson < CableException
    def initialize(msg = nil)
      msg ||= '请勿重复购买'
      super
      @code = 2001
    end
  end


  class OngoingLesson < CableException
    def initialize(msg = nil)
      msg ||= '有正在进行的课程'
      super
      @code = 2002
    end
  end


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


  class TypeError < CableException
    def initialize(msg = nil)
      msg ||= '类型不对'
      super
      @code = 1002
    end
  end

  class PermissionError < CableException

    def initialize(msg = nil)
      msg ||= '没有权限'
      super
      @code = 1003
    end
  end

  class SkycodeNotFound < CableException
    def initialize(msg = nil)
      msg ||= '没有找到 skycode'
      super
      @code = 1004
    end
  end

  class SkycodeAlreadyBinded < CableException
    def initialize(msg = nil)
      msg ||= 'skycode已被绑定'
      super
      @code = 1005
    end
  end

  class UniversityNotFound < CableException
    def initialize(msg = nil)
      msg ||= '未找到学校'
      super
      @code = 1006
    end
  end



  class BussinessCardReadError < CableException
    def initialize(msg = nil)
      msg ||= '您不能群发通知类信息'
      super
      @code = 1007
    end
  end

  class NotAllowedSendPointMessage < CableException
    def initialize(msg = nil)
      msg ||= '您不能发送信息'
      super
      @code = 1008
    end
  end


  class NotAllowedSendSubscriptionMessage < CableException
    def initialize(msg = nil)
      msg ||= '您不能发送订阅类信息'
      super
      @code = 1009
    end
  end




  class NotFoundGroup < CableException
    def initialize(msg = nil)
      msg ||= '不能找到群组'
      super
      @code = 1010
    end
  end

end
