# frozen_string_literal: true
module Chihiro
  class JsonLogFormatter < Logger::Formatter
    def call(severity, _time, _progname, msg)
      extra_log_data(msg).merge(
        "level": severity.downcase,
        "project": ENV['PROJECT_NAME'],
        "environment": ENV['RAILS_ENV'],
        "application": ENV['APP_NAME'],
        "dateTime": Time.now
      ).to_json + "\r\n"
    end

    private

    def extra_log_data(msg)
      if msg.is_a? Hash
        msg
      elsif msg.is_a? Exception
        { "message": msg.message, "backtrace": msg.backtrace }
      else
        { "message": msg }
      end
    end
  end
end