module Reractor
  module InputQueue
    class Kafka
      def initialize(consumer_group:, host:)
      end

      def create(pipe)
        # Spawn new kafka instance
        loop do
          pipe << "input message from #{Thread.current.object_id}"
        end
      end
    end
  end
end