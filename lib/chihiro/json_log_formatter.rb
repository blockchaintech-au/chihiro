# frozen_string_literal: true

require 'logger'

module Chihiro
  class JsonLogFormatter < ::Logger::Formatter
    def call(severity, _time, _progname, msg)
      base_data = {
        level: severity.downcase,
        project: ENV['PROJECT'],
        environment: ENV['ENVIRONMENT'],
        application: ENV['APP_NAME'],
        datetime: Time.now
      }
      correlation_id = Thread.current[:correlation_id]
      base_data.merge!(correlationId: correlation_id) if correlation_id
      extra_log_data(msg).merge(base_data).to_json + "\r\n"
    end

    private

    def extra_log_data(msg)
      if msg.is_a? Hash
        FlattenUtil.flat(MaskUtil.mask(msg))
      elsif msg.is_a? Exception
        { message: msg.message, backtrace: msg.backtrace }
      else
        { message: msg }
      end
    end
  end
end
