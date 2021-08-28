module Reractor
  class Message
    attr_reader :id, :ttid, :event, :origin, :timestamp, :event_data

    def self.from(data)
      raise Reractor::Error::InvalidMessageFormat unless data.is_a?(Hash)

      Message.new(data)
    end

    def self.error(ttid:, service_name:, exception:)
      Message.new({
        "id" => SecureRandom.uuid,
        "ttid" => ttid,
        "event" => "handler.failed",
        "origin" => service_name,
        "timestamp" => Time.now.to_i,
        "event_data" => {
          "exception_class": exception.class,
          "exception_message": exception.message,
          "exception_backtrace": exception.backtrace.join("\n")
        }
      })
    end

    def initialize(data)
      @id = required_field("id", data, String)
      @ttid = required_field("ttid", data, String)
      @event = required_field("event", data, String)
      @origin = required_field("origin", data, String)
      @timestamp = required_field("timestamp", data, Integer)
      @event_data = required_field("event_data", data, Hash)
    end

    def to_hash
      {
        id: @id,
        ttid: @ttid,
        event: @event,
        origin: @origin,
        timestamp: @timestamp,
        event_data: @event_data
      }
    end

    private

    def required_field(field, data, type)
      raise Reractor::Error::MissingMessageField unless data[field]
      raise Reractor::Error::IncorrectFieldType unless data[field].class == type
      data[field]
    end

  end
end