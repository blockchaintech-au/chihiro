module Chihiro
  class Initializer
    def execute
      Rails.application.configure do
        config.log_formatter = Chihiro::JsonLogFormatter.new
        config.colorize_logging = false
        config.lograge.enabled = true
        config.lograge.base_controller_class = "ActionController::API"
        config.lograge.ignore_actions = ["HealthCheckController#index"]
        if ENV["RAILS_LOG_TO_STDOUT"].present?
          logger = ActiveSupport::Logger.new(STDOUT)
          logger.formatter = config.log_formatter
          config.logger = logger
        end
      end
    end
  end
end
