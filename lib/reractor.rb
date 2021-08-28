gem_dir = Gem::Specification.find_by_name("reractor").gem_dir
require "#{gem_dir}/lib/handler.rb"
require "#{gem_dir}/lib/processor.rb"
require "#{gem_dir}/lib/input_queue/kafka.rb"
require "#{gem_dir}/lib/output_queue/kafka.rb"

module Reractor
  def self.configuration
    @configuration ||= {}
  end

  def self.configure
    yield(configuration)
  end

  def self.run
    input_pipe = Ractor.new { loop { Ractor.yield Ractor.receive } }
    output_pipe = Ractor.new { loop { Ractor.yield Ractor.receive } }

    input_ractors = Reractor.configuration[:number_of_input_threads].times.map do
      Ractor.new input_pipe, Reractor.configuration do |p, c|
        c[:input_queue].create(p)
      end
    end

    output_ractors = Reractor.configuration[:number_of_output_threads].times.map do
      Ractor.new output_pipe, Reractor.configuration do |p, c|
        c[:output_queue].create(p)
      end
    end

    processing_ractors = Reractor.configuration[:number_of_processing_threads].times.map do
      Ractor.new input_pipe, output_pipe, Reractor::Registry.list do |i,o,list|
        Processor.new(input_pipe: i, output_pipe: o, handler_list: list)
      end
    end

    processing_ractors.map { |r| r.take }
  end
end