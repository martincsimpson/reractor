module Reractor
  class Processor
    def initialize input_pipe:, output_pipe:, handler_list:, configuration:
      loop do
        m = input_pipe.take

        msg = Reractor::Message.from(input_pipe.take)

        handler = handler_list.find { |h| h.can_process?(msg) }

        event_data = handler.handle(msg)

        response = {
          "id" => SecureRandom.uuid,
          "ttid" => msg.ttid,
          "event" => handler.output_event,
          "origin" => configuration[:service_name],
          "timestamp" => Time.now.to_i,
          "event_data" => event_data
        }

        response_message = Reractor::Message.from(response)

        output_pipe << response_message
      end
    end
  end
end