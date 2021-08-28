require 'reractor'

Reractor.configure do |config|
  config[:number_of_input_threads] = 2
  config[:number_of_output_threads] = 2
  config[:number_of_processing_threads] = 20
  config[:input_queue] = Reractor::InputQueue::Loop.new
  config[:output_queue] = Reractor::OutputQueue::Stdout.new
  config[:handler_directory] = "handlers"
  config[:auto_register_handlers] = true
  config[:service_name] = "test_service"
end

Reractor.run