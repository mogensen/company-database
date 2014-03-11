# Require the bundler gem and then call Bundler.require to load in all gems
# listed in Gemfile.
require 'bundler'
Bundler.require

require_relative 'models/init'
require_relative 'routes/main'
require_relative 'routes/json-api'
require_relative 'helpers/accessors'
