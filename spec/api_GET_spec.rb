ENV['RACK_ENV'] = 'test'

require 'spec_helper.rb'

describe 'API' do

	before(:each) do
		# cleanup database
		Company.all.destroy
	end

	it "GET /companies" do
		c1 = {
			:name => 'Company 1',
			:address => 'Langelandsgade 9',
			:city => 'Aarhus',
			:country => 'Denmark'}
		# create in data base
		Company.create(c1)
		c2 = {
			:name => 'Company 2',
			:address => 'Ny Munkegade 116',
			:city => 'Aarhus',
			:country => 'Denmark'}
		Company.create(c2)

		# get REST GET request
		get "/companies"

		# test 'ok' respone
		last_response.should be_ok

		# parse JSON
		info = JSON::parse(last_response.body)
		info['companies'].size.should == 2
		info['companies'][0]['name'].should    == 'Company 1'
		info['companies'][0]['address'].should == 'Langelandsgade 9'
		info['companies'][0]['city'].should    == 'Aarhus'
		info['companies'][0]['country'].should == 'Denmark'
		info['companies'][1]['name'].should    == 'Company 2'
		info['companies'][1]['address'].should == 'Ny Munkegade 116'
		info['companies'][1]['city'].should    == 'Aarhus'
		info['companies'][1]['country'].should == 'Denmark'
	end

	it "GET /companies/ID" do
		# create in data base
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
	end

end
