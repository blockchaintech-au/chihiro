
# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chihiro/version'

Gem::Specification.new do |spec|
  spec.name = 'chihiro'
  spec.version = Chihiro::VERSION
  spec.authors = ['Shu Hui']
  spec.email = ['dreamlock0630@gmail.com']

  spec.summary = 'Tool for rails log format'
  spec.description = 'Change rails log to Json format'
  spec.homepage = 'https://github.com/blockchaintech-au/chihiro'
  spec.license = 'MIT'

  spec.files = Dir['**/*'].keep_if { |file| File.file?(file) }
  spec.require_paths = ['lib']

  spec.add_dependency 'lograge', '~> 0.10'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
