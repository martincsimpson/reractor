module Reractor
  class Handler

    def self.inherited(subclass)
      Reractor::Registry.register(subclass)
    end

    def can_process?(msg)
      self.input_events.include?(msg.event)
    end

    def input_events
      raise NotImplementedError
    end

    def output_event
      raise NotImplementedError
    end

    def handle(msg)
      raise NotImplementedError
    end

  end
end