require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Eventmngmt
	class Application < Rails::Application
		config.time_zone = 'Kyiv'
		# Settings in config/environments/* take precedence over those specified here.
		# Application configuration should go into files in config/initializers
		# -- all .rb files in that directory are automatically loaded.
		# config.middleware.insert_before 0, "Rack::Cors" do
		# 	allow do
		# 		origins '*'
		# 		resource '*',
		# 		  headers: :any,
		# 		  methods: [:get, :post, :delete, :put, :options],
		# 		  max_age: 0
		# 	end
		# end

		# config.middleware.use ActionDispatch::Flash
	end
end
