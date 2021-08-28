module Reractor
  class Handler

    # Used on startup to figure out what handlers there are
    def self.inherited(subclass)
      Reractor::Registry.register(subclass)
    end

    # Used by an instance of a handler to determine if it can be processed
    def can_process?(msg)
      self.input_events.include?(msg.event)
    end

    # Need to be implemented by the handlers
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