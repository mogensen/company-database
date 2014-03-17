require 'spec_helper.rb'

describe 'API POST' do

	before(:each) do
		# cleanup database
		Director.all.destroy
		Company.all.destroy

		# Create test company
		c = {
			:name => 'Company 1',
			:address => 'Company Street 2',
			:city => 'Aarhus',
			:country => 'Denmark'}
		json = { :company => c}

		post '/companies', json.to_json
		last_response.should be_ok

		# test in database
		Company.count.should == 1

		# Test in database
		Company.first.name.should    == 'Company 1'
		Company.first.address.should == 'Company Street 2'
		Company.first.city.should    == 'Aarhus'
		Company.first.country.should == 'Denmark'

		Company.count.should == 1
		Director.count.should == 0

		# POST request, for create Company
		company  = Company.first
		company.directors.count.should == 0

	end

	it "should add a new director at endpoint /companies/{id}/directors" do
		# POST request, for create Company
		company  = Company.first
		company.directors.count.should == 0

		# POST request, for create Director
		d = {
			:name => 'Peter',
			:address => 'Directorstreet 2',
			:city => 'Aars',
			:country => 'Denmark'}
		json = { :director => d}

		post "/companies/#{company.id}/directors", json.to_json
		last_response.should be_ok

		company.directors.count.should == 1

		company.directors.first.name.should    == 'Peter'
		company.directors.first.address.should == 'Directorstreet 2'
		company.directors.first.city.should    == 'Aars'
		company.directors.first.country.should == 'Denmark'

	end

	it "without name returns error at endpoint /companies/{id}/directors" do
		# POST request, for create Company
		company  = Company.first
		company.directors.count.should == 0

		# POST request, for create Director
		d = {
			:address => 'Directorstreet 2',
			:city => 'Aars',
			:country => 'Denmark'}
		json = { :director => d}

		post "/companies/#{company.id}/directors", json.to_json
		last_response.status.should eql 422

		# parse JSON
		info = JSON::parse(last_response.body)
		info['errors']['name'].should == ['Name must not be blank']

		# test in database
		Director.count.should == 0
	end

	it "without address returns error at endpoint /companies/{id}/directors" do
		# POST request, for create Company
		company  = Company.first
		company.directors.count.should == 0

		# POST request, for create Director
		d = {
			:name => 'Peter',
			:city => 'Aars',
			:country => 'Denmark'}
		json = { :director => d}

		post "/companies/#{company.id}/directors", json.to_json
		last_response.status.should eql 422

		# parse JSON
		info = JSON::parse(last_response.body)
		info['errors']['address'].should == ['Address must not be blank']

		# test in database
		Director.count.should == 0
	end

	it "without city returns error at endpoint /companies/{id}/directors" do
		# POST request, for create Company
		company  = Company.first
		company.directors.count.should == 0

		# POST request, for create Director
		d = {
			:name => 'Peter',
			:address => 'Directorstreet 2',
			:country => 'Denmark'}
		json = { :director => d}

		post "/companies/#{company.id}/directors", json.to_json
		last_response.status.should eql 422

		# parse JSON
		info = JSON::parse(last_response.body)
		info['errors']['city'].should == ['City must not be blank']

		# test in database
		Director.count.should == 0
	end

	it "without country returns error at endpoint /companies/{id}/directors" do
		Company.count.should == 1
		Director.count.should == 0

		# POST request, for create Company
		company  = Company.first
		company.directors.count.should == 0

		# POST request, for create Director
		d = {
			:name => 'Peter',
			:address => 'Directorstreet 2',
			:city => 'Aars'}
		json = { :director => d}

		post "/companies/#{company.id}/directors", json.to_json
		last_response.status.should eql 422


		# parse JSON
		info = JSON::parse(last_response.body)
		info['errors']['country'].should == ['Country must not be blank']

		# test in database
		Director.count.should == 0
	end
end
