module Reractor
  module OutputQueue
    class Kafka
      def initialize(host:)
      end

      def create(pipe)
        loop do
          msg = pipe.take
          puts "Ouptut by #{Thread.current.object_id}: #{msg}"
        end
      end
    end
  end
end