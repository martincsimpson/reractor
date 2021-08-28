class TestHandler < Reractor::Handler

  def input_events
    ["something.happened"]
  end

  def output_event
    "something.updated"
  end

  def handle(msg)
    {
      message: "blah"
    }
  end
end