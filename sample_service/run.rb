require 'reractor'

require "./handlers/test_handler.rb"

Reractor.configure do |config|
  config[:number_of_input_threads] = 2
  config[:number_of_output_threads] = 2
  config[:number_of_processing_threads] = 20
  config[:input_queue] = Reractor::InputQueue::Kafka.new(consumer_group: "abc", host: "localhost")
  config[:output_queue] = Reractor::OutputQueue::Kafka.new(host: "localhost")
  config[:handler_directory] = "./handlers"
  config[:auto_register_handlers] = true
end

Reractor.run