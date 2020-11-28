require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
# require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
# require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require 'action_view/railtie'
# require 'action_cable/engine'
# require "sprockets/railtie"
# require "rails/test_unit/railtie"


Bundler.require(*Rails.groups)

module RubyDumpApi
  class Application < Rails::Application
    config.load_defaults 6.0

    config.generators.system_tests = nil

    config.active_job.queue_adapter = :sidekiq

    config.eager_load_paths << Rails.root.join('lib')
    config.hosts = nil
    # Rails.application.config.hosts << Rails.application.credentials[Rails.env.to_sym][:host_name] # new in rails 6
  end
end
