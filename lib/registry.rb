module Reractor
  class Registry
    @@handlers = []

    def self.register(handler)
      @@handlers << handler.new
    end

    def self.list
      @@handlers
    end

  end
end