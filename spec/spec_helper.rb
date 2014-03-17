ENV['RACK_ENV'] = 'test'

require 'bundler'
Bundler.require(:default, :test)
Coveralls.wear!


require File.expand_path '../../app.rb', __FILE__

module RSpecMixin
	include Rack::Test::Methods
	def app() CompanyDatabase end
end


RSpec.configure do |config|
	config.include RSpecMixin

	DataMapper::setup(:default, "sqlite://#{Dir.pwd}/api-test.sqlite")
	DataMapper.finalize
	DataMapper.auto_migrate!

	#config.order = 'random'
end
