require 'spec_helper.rb'

describe 'API PUT' do

	before(:each) do
		# cleanup database
		Director.all.destroy
		Company.all.destroy
	end

	it "should update company at endpoint /companies/ID" do
		Company.count.should == 0

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

	it "should update director at endpoint /companies/ID/directors/ID" do
		Company.count.should == 0

		# Create in data base
		
		c = {
			:name => 'Company With Director',
			:address => 'Langelandsgade 9',
			:city => 'Aarhus',
			:country => 'Denmark'}
		c1 = Company.create(c)

		d = {
			:name => 'Peter',
			:address => 'Directorstreet 2',
			:city => 'Aars',
			:country => 'Denmark'}
		c1.directors.create(d)

		get "/companies/#{c1.id}/directors/#{c1.directors.first.id}"
		
		last_response.should be_ok

		# parse JSON
		info = JSON::parse(last_response.body)
		info['director']['name'].should    == 'Peter'
		info['director']['address'].should == 'Directorstreet 2'
		info['director']['city'].should    == 'Aars'
		info['director']['country'].should == 'Denmark'

		newInfo = { :director => {:name => 'Peter K'} }

		put "/companies/#{c1.id}/directors/#{c1.directors.first.id}", newInfo.to_json
		last_response.should be_ok

		get "/companies/#{c1.id}/directors/#{c1.directors.first.id}"
		last_response.should be_ok

		# parse JSON
		info = JSON::parse(last_response.body)
		info['director']['name'].should == 'Peter K'
	end

end
