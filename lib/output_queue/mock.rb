module Reractor
  module OutputQueue
    class Mock
      def create(pipe)
        loop do
          msg = pipe.take
          puts msg.to_hash
        end
      end
    end
  end
end