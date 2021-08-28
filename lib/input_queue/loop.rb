module Reractor
  module InputQueue
    class Loop
      def create(pipe)
        loop do
          pipe << {
            "id" => SecureRandom.uuid,
            "ttid" => SecureRandom.uuid,
            "event" => "something.happened",
            "timestamp" => Time.now.to_i,
            "origin" => "some-service",
            "event_data" => {}
          }
        end
      end
    end
  end
end