class TestHandler < Reractor::Handler

  def input_events
    ["something.happened"]
  end

  def output_event
    "something.updated"
  end

  def handle(msg)
    # Test error handling
    if rand(10) == 5
      raise "Something broke"
    end

    # Send back a hash
    {
      message: "blah"
    }
  end
end