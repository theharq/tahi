class Listener
  def initialize(klass, method_sym)
    @klass = klass
    @method_sym = method_sym
  end

  def notify(*args)
    @klass.send(@method_sym, *args)
  end
end

class Bus
  def self.message(msg, context={})
    @subscribers[msg].each { |s| s.notify(context) }
  end

  def self.subscribe(msg, klass, method_sym)
    @subscribers ||= Hash.new { [] }
    @subscribers[msg] = @subscribers[msg] << Listener.new(klass, method_sym)
  end
end

