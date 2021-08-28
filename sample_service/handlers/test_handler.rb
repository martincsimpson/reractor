class TestHandler < Reractor::Handler
  def handle(msg)
    puts "Hello #{msg}"
  end
end