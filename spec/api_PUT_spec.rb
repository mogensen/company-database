ENV['RACK_ENV'] = 'test'

require 'spec_helper.rb'

describe 'API' do

	before(:each) do
		# cleanup database
		Company.all.destroy
	end

	it "PUT /companies/ID" do
		# Create in data base
		c = {
			:name => 'Company 1',
			:address => 'Langelandsgade 9',
			:city => 'Aarhus',
			:country => 'Denmark'}
		c1 = Company.create(c)

		# get REST GET request
		get "/companies/#{c1.id}"

		last_response.should be_ok

		# parse JSON
		info = JSON::parse(last_response.body)
		info['company']['name'].should    == 'Company 1'
		info['company']['address'].should == 'Langelandsgade 9'
		info['company']['city'].should    == 'Aarhus'
		info['company']['country'].should == 'Denmark'

		newInfo = { :company => {:name => 'New Company Name'} }

		put "/companies/#{c1.id}", newInfo.to_json
		last_response.should be_ok

		get "/companies/#{c1.id}"
		last_response.should be_ok

		# parse JSON
		info = JSON::parse(last_response.body)
		info['company']['name'].should == 'New Company Name'
	end

end
