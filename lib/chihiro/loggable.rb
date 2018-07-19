module Chihiro
  module Loggable
    extend ActiveSupport::Concern

    included do
      around_action :log_and_deal_exceptions
    end

    private

    def log_and_deal_exceptions
      log_request
      yield
      log_response
    rescue => e
      log_exception(e)
      raise
    end
  
    def log_request
      to_log = {
        message: 'Received API request',
        requestPath: request.path,
        password: 'password'
      }
      if Rails.configuration.no_log_param_paths.include?("#{controller_name}##{action_name}")
        Rails.logger.info(to_log)
      else
        Rails.logger.info(to_log.merge(params: params.as_json))
      end
    end
  
    def log_response
      to_log = {
        message: 'Send API Response',
        requestPath: request.path,
        responseStatus: response.status.to_s
      }
      Rails.logger.info(to_log)
    end
  
    def log_exception(e)
      to_log = {
        message: 'Catched exception in controller',
        requestPath: request.path,
        exceptionClass: e.class.to_s,
        exceptionMessage: e.message,
        backtrace: e.backtrace
      }
      Rails.logger.error(to_log)
    end
  end
end