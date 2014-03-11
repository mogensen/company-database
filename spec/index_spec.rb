ENV['RACK_ENV'] = 'test'

require 'spec_helper.rb'

describe 'API' do

	before(:each) do
		# cleanup database
		Company.all.destroy
	end

	it "Start page ok" do
		get "/"
		last_response.should be_ok
	end

end
