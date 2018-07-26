# frozen_string_literal: true

module Chihiro
  class Initializer
    def execute
      init_no_log_params_paths
      setup_log_configuration if ENV['RAILS_ENV'] == 'production'
    end

    private

    def init_no_log_params_paths
      Rails.application.configure do
        config.no_log_param_paths = []
      end
    end

    def setup_log_configuration # rubocop:disable Metrics/MethodLength
      Rails.application.configure do
        config.log_formatter = Chihiro::JsonLogFormatter.new
        config.colorize_logging = false
        config.lograge.enabled = true
        config.lograge.base_controller_class = 'ActionController::API'
        config.lograge.ignore_actions = ['HealthCheckController#index', 'HealthCheckController#quick_health']

        if ENV['RAILS_LOG_TO_STDOUT'].present?
          logger = ActiveSupport::Logger.new(STDOUT)
          logger.formatter = config.log_formatter  
          config.logger = logger
        end
      end
    end
  end
end
