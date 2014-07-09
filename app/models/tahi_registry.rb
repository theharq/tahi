class TahiRegistry
  class Subscriber
    def initialize(klass, method_sym)
      @klass = klass
      @method_sym = method_sym
    end

    def notify(*args)
      @klass.send(@method_sym, *args)
    end

    def to_s
      "#{@klass.name}.#{@method_sym}"
    end
  end

  def self.subscribe(msg, klass, method_sym)
    subscribers[msg] = subscribers[msg] << Subscriber.new(klass, method_sym)
  end

  def self.deliver(msg, context={})
    subscribers_of_message(msg).each { |s| s.notify(context) }
  end

  def self.subscribers
    @subscribers ||= Hash.new { [] }
  end

  def self.subscribers_of_message(msg)
    subscribers[msg]
  end
end
