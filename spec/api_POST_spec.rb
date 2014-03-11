ENV['RACK_ENV'] = 'test'

require 'spec_helper.rb'

describe 'API' do

	before(:each) do
		# cleanup database
		Company.all.destroy
	end

	it "POST /companies" do
		Company.count.should == 0

		# POST request, for create Company with 'name' parametr
		c = {
			:name => 'Company 1',
			:address => 'Langelandsgade 9',
			:city => 'Aarhus',
			:country => 'Denmark'}
		json = { :company => c}

		post '/companies', json.to_json
		last_response.should be_ok

		# test in database
		Company.count.should == 1

		# test in database
		Company.first.name.should    == 'Company 1'
		Company.first.address.should == 'Langelandsgade 9'
		Company.first.city.should    == 'Aarhus'
		Company.first.country.should == 'Denmark'
	end

	it "POST /companies without name returns error" do
		Company.count.should == 0

		# POST request, for create Company with 'name' parametr
		c = {
			:address => 'Langelandsgade 9',
			:city => 'Aarhus',
			:country => 'Denmark'}
		json = { :company => c}

		post '/companies', json.to_json
		last_response.status.should eql 422

		# parse JSON
		info = JSON::parse(last_response.body)
		info['errors']['name'].should == ['Name must not be blank']

		# test in database
		Company.count.should == 0
	end

	it "POST /companies without address returns error" do
		Company.count.should == 0

		# POST request, for create Company with 'name' parametr
		c = {
			:name => 'Company 1',
			:city => 'Aarhus',
			:country => 'Denmark'}
		json = { :company => c}

		post '/companies', json.to_json
		last_response.status.should eql 422

		# parse JSON
		info = JSON::parse(last_response.body)
		info['errors']['address'].should == ['Address must not be blank']

		# test in database
		Company.count.should == 0
	end

	it "POST /companies without city returns error" do
		Company.count.should == 0

		# POST request, for create Company with 'name' parametr
		c = {
			:name => 'Company 1',
			:address => 'Langelandsgade 9',
			:country => 'Denmark'}
		json = { :company => c}

		post '/companies', json.to_json
		last_response.status.should eql 422

		# parse JSON
		info = JSON::parse(last_response.body)
		info['errors']['city'].should == ['City must not be blank']

		# test in database
		Company.count.should == 0
	end

	it "POST /companies without country returns error" do
		Company.count.should == 0

		# POST request, for create Company with 'name' parametr
		c = {
			:name => 'Company 1',
			:address => 'Langelandsgade 9',
			:city => 'Aarhus'}
		json = { :company => c}

		post '/companies', json.to_json
		last_response.status.should eql 422

		# parse JSON
		info = JSON::parse(last_response.body)
		info['errors']['country'].should == ['Country must not be blank']

		# test in database
		Company.count.should == 0
	end
end
