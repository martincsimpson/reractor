module Reractor
  class Processor
    def initialize input_pipe:, output_pipe:, handler_list:, configuration:
      loop do
        # Take a method from the pipe
        msg = Reractor::Message.from(input_pipe.take)

        # Find a handler that can process the message
        handler = handler_list.find { |h| h.can_process?(msg) }

        begin
          # Process the message through the handler
          # return data should be the event data hash
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
        rescue StandardError => e
          # in case of an error, we generate an error
          # event and send that to the output queue
          response_message = Reractor::Message.error(ttid: msg.ttid, service_name: configuration[:service_name], exception: e)
        end

        # Put the message onto the output pipe
        output_pipe << response_message.to_hash
      end
    end
  end
end