module Reractor
  module Error

    class InvalidMessageFormat < StandardError; end
    class MissingMessageField < StandardError; end
    class IncorrectFieldType < StandardError; end

  end
end