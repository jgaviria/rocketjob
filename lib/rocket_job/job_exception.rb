# encoding: UTF-8
module RocketJob
  # Heartbeat
  #
  # Information from the worker as at it's last heartbeat
  class JobException
    include Plugins::Document

    # Name of the exception class
    field :class_name, type: String

    # Exception message
    field :message, type: String

    # Exception Backtrace [Array<String>]
    field :backtrace, type: Array, default: []

    # Name of the worker on which this exception occurred
    field :worker_name, type: String

    # The record within which this exception occurred
    field :record_number, type: Integer

    # Returns [JobException] built from the supplied exception
    def self.from_exception(exc)
      new(
        class_name: exc.class.name,
        message:    exc.message,
        backtrace:  exc.backtrace || []
      )
    end

  end
end