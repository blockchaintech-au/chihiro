module Chihiro
  module Loggable
    extend ActiveSupport::Concern

    included do
      around_action :log_and_deal_exceptions
    end

    private

    def should_ignore_logging?
      return false unless Rails.configuration.lograge.ignore_actions
      Rails.configuration.lograge.ignore_actions.include?("#{controller_name.camelize}Controller##{action_name}")
    end

    def log_and_deal_exceptions
      log_request unless should_ignore_logging?
      yield
      log_response unless should_ignore_logging?
    rescue => e
      log_exception(e)
      raise
    end
  
    def log_request
      to_log = {
        message: 'Received API request',
        requestPath: request.path,
        requestMethod: request.request_method
      }
      if Rails.configuration.no_log_param_paths.include?("#{controller_name}##{action_name}")
        Rails.logger.info(to_log)
      else
        Rails.logger.info(to_log.merge(params: params.except(:format, :controller, :action).as_json))
      end
    end
  
    def log_response
      to_log = {
        message: 'Send API Response',
        requestPath: request.path,
        requestMethod: request.request_method,
        responseStatus: response.status.to_s
      }
      Rails.logger.info(to_log)
    end
  
    def log_exception(e)
      to_log = {
        message: 'Catched exception in controller',
        requestPath: request.path,
        requestMethod: request.request_method,
        exceptionClass: e.class.to_s,
        exceptionMessage: e.message,
        backtrace: e.backtrace
      }
      Rails.logger.error(to_log)
    end

    def log_known_exception(e)
      to_log = {
        message: 'Catched known exception in controller',
        requestPath: request.path,
        requestMethod: request.request_method,
        exceptionClass: e.class.to_s,
        exceptionMessage: e.message
      }
      Rails.logger.warn(to_log)
    end
  end
end