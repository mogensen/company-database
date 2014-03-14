require 'spec_helper.rb'

describe 'API GET' do

	before(:each) do
		# cleanup database
		Director.all.destroy
		Company.all.destroy
	end

	it "should return all companies at endpoint /companies" do
		Company.count.should == 0
		
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

	it "should return company at endpoint /companies/ID" do
		Company.count.should == 0
		
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

	it "should return all directors at a company at endpoint /companies/ID/directors" do
		Company.count.should == 0

		c = {
			:name => 'Company 1',
			:address => 'Langelandsgade 9',
			:city => 'Aarhus',
			:country => 'Denmark'}
		c1 = Company.create(c)

		# test in database
		Company.count.should == 1


		d = {
			:name => 'Peter',
			:address => 'Directorstreet 2',
			:city => 'Aars',
			:country => 'Denmark'}
		c1.directors.create(d)

		# get REST GET request
		get "/companies/#{c1.id}/directors"

		last_response.should be_ok

		# parse JSON
		info = JSON::parse(last_response.body)
		info['directors'][0]['name'].should    == 'Peter'
		info['directors'][0]['address'].should == 'Directorstreet 2'
		info['directors'][0]['city'].should    == 'Aars'
		info['directors'][0]['country'].should == 'Denmark'
	end

	it "should return specific director at a company at endpoint /companies/ID/directors/ID" do
		Company.count.should == 0

		# New company
		c = {
			:name => 'Company With Director',
			:address => 'Langelandsgade 9',
			:city => 'Aarhus',
			:country => 'Denmark'}
		c1 = Company.create(c)

		# First new director
		d = {
			:name => 'Peter',
			:address => 'Directorstreet 2',
			:city => 'Aars',
			:country => 'Denmark'}
		c1.directors.create(d)

		# Director from an other company
		d = {
			:name => 'Allan',
			:address => 'Directorstreet 3',
			:city => 'Aars',
			:country => 'Denmark'}
		Director.create(d)

		# Second new director
		d = {
			:name => 'Lasse',
			:address => 'Directorstreet 4',
			:city => 'Aalestrup',
			:country => 'Denmark'}
		c1.directors.create(d)

		c1.save

		# get REST GET request
		get "/companies/#{c1.id}/directors/#{c1.directors.first.id}"
		last_response.should be_ok

		# parse JSON
		info = JSON::parse(last_response.body)
		info['director']['name'].should    == 'Peter'
		info['director']['address'].should == 'Directorstreet 2'
		info['director']['city'].should    == 'Aars'
		info['director']['country'].should == 'Denmark'

		# get REST GET request
		get "/companies/#{c1.id}/directors/#{c1.directors[1].id}"
		last_response.should be_ok

		# parse JSON
		info = JSON::parse(last_response.body)
		info['director']['name'].should    == 'Lasse'
		info['director']['address'].should == 'Directorstreet 4'
		info['director']['city'].should    == 'Aalestrup'
		info['director']['country'].should == 'Denmark'
	end
end
