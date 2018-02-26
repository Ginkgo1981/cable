class Hash
  def format_time!
    self.inject({}) do |h, (k, v)|
      h = h.merge k.to_sym => (k[/_at|_time/] && v.present? && v.is_a?(ActiveSupport::TimeWithZone) ? v.to_time.strftime("%Y-%m-%d %H:%M:%S") : v)
    end
  end
end

class NilClass
  def [](key)
    nil
  end
end

class ActiveSupport::TimeWithZone
  def to_short(is_text = false, need_year = false)
    arr = ['%Y年' '%m月%d日']
    arr.delete_at(0) unless need_year
    is_text ? self.strftime(arr.join) : self.strftime('%F')
  end

  def to_long(is_text = false, need_year = false)
    arr = ['%Y年', '%m月%d日 %R']
    arr.delete_at(0) unless need_year
    is_text ? self.strftime(arr.join) : self.strftime('%F %R')
  end

  def to_full(is_text = false, need_year = false)
    arr = ['%Y年', '%m月%d日 %T']
    arr.delete_at(0) unless need_year
    is_text ? self.strftime(arr.join) : self.strftime('%F %T')
  end

  def to_now_short #不足1小时显示分钟，不足1天显示小时，超过1天显示天数
    d = Time.now - self.to_time
    return "刚刚" if d <= 1.minute
    return "#{(d/1.minute).round}分钟前" if d <= 1.hour
    return "#{(d/1.hour).round}小时前" if d <= 1.day
    "#{(d/1.day).round}天前"
  end

end


class Integer
  #how-to-use  7.days.to_i.formatted_duration
  def formatted_duration
    total_seconds = self.to_i
    strDate = ""
    if total_seconds >= (24 * 60 * 60)
      days = total_seconds / (24 * 60 *60 )
      total_seconds = total_seconds - (days * 24 * 60 * 60)
      strDate += "#{days}天"
    end
    hours = total_seconds / (60 * 60)
    minutes = (total_seconds / 60) % 60
    seconds = total_seconds % 60
    strDate += "#{ hours }小时 #{ minutes }分"
    strDate
  end


end


class String
  def to_range
    case self.count('.')
      when 2
        elements = self.split('..')
        return Range.new(elements[0].to_i, elements[1].to_i)
      when 3
        elements = self.split('...')
        return Range.new(elements[0].to_i, elements[1].to_i-1)
      else
        raise ArgumentError.new("Couldn't convert to Range: #{str}")
    end
  end
end


