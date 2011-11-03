require "logger"

class SplitLogger < Logger
  attr_accessor :logs, :shift_age, :shift_size
  
  def initialize(logdev, shift_age = 0, shift_size = 1048576)
    shift_age = shift_age
    shift_size = shift_size
    super(logdev, shift_age, shift_size)
  end
  
  def add(severity, message = nil, progname = nil, &block)
    severity ||= UNKNOWN
    if @logs and @logs.is_a?(Hash) and el = @logs.find{|k,v| Array(v).include?(severity)}
      k = el.first
      if k.is_a?(String)
        sublogdev = LogDevice.new(k, :shift_age => shift_age, :shift_size => shift_size)
        @logs[sublogdev] = @logs.delete(k)
      elsif k.is_a?(LogDevice)
        sublogdev = k
      end
    elsif @logdev.nil? or severity < @level
      return true
    end

    progname ||= @progname
    sublogdev ||= @logdev
    
    if message.nil?
      if block_given?
        message = yield
      else
        message = progname
        progname = @progname
      end
    end
    
    sublogdev.write(
      format_message(format_severity(severity), Time.now, progname, message))
    true
  end
end