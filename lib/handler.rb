module Reractor
  class Handler

    def self.inherited(subclass)
      puts "#{subclass} registered as a handler"
      Registry.register(subclass)
    end

    def can_process(msg)
      # Check type matches
    end
  end
end