module Reractor
  class Processor
    def initialize input_pipe:, output_pipe:, handler_list:
      loop do
        msg = Reractor::Message.from(input_pipe.take)

        handler_list.find { |h| h.can_process?(msg) }
        # Find Correct handler
        puts "I Have #{handler_list}"

        output_pipe << "Message was processed by #{Thread.current.object_id}: #{msg}"
      end
    end
  end
end