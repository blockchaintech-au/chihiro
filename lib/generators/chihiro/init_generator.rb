# frozen_string_literal: true

module Chihiro
  class InitGenerator < Rails::Generators::Base
    source_root File.expand_path("templates", __dir__)
    desc "Generate totoro config file"

    def copy_config_file
      template "initializer.rb", File.join("config/initializers", "chihiro.rb")
    end
  end
end
