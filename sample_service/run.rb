require 'reractor'

Reractor.configure do |config|
  config[:number_of_input_threads] = 2
  config[:number_of_output_threads] = 2
  config[:number_of_processing_threads] = 20
  config[:input_queue] = Reractor::InputQueue::Loop
  config[:output_queue] = Reractor::OutputQueue::Stdout
  config[:handler_directory] = "handlers"
  config[:service_name] = "test_service"
end

Reractor.run