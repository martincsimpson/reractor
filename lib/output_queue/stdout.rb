module Reractor
  module OutputQueue
    class Stdout
      def create(pipe)
        loop do
          msg = pipe.take
          puts msg.to_hash
        end
      end
    end
  end
end