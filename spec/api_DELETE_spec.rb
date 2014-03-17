require 'spec_helper.rb'

describe 'API DELETE' do

	before(:each) do
		# cleanup database
		Director.all.destroy
		Company.all.destroy
	end

	it "should delete a company at endpoint /companies/{id}" do
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

		delete "/companies/#{Company.first.id}"
		last_response.should be_ok

		Company.count.should == 0

	end

	it "should delete a director at endpoint /companies/{id}/directors/{id}" do
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

		d = {
			:name => 'Peter',
			:address => 'Directorstreet 2',
			:city => 'Aars',
			:country => 'Denmark'}
		d1 = Company.first.directors.create(d)

		Company.first.directors.count.should == 1

		d = {
			:name => 'Jane Doe',
			:address => 'Directorstreet 3',
			:city => 'Aars',
			:country => 'Denmark'}
		d2 = Company.first.directors.create(d)

		Company.first.directors.count.should == 2

		delete "/companies/#{Company.first.id}/directors/#{d1.id}"
		last_response.should be_ok

		Company.first.directors.count.should == 1 

	end

	it "should delete the correct director at endpoint /companies/{id}/directors/{id}" do
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

		d = {
			:name => 'Peter',
			:address => 'Directorstreet 2',
			:city => 'Aars',
			:country => 'Denmark'}
		d1 = Company.first.directors.create(d)

		Company.first.directors.count.should == 1

		d = {
			:name => 'Jane Doe',
			:address => 'Directorstreet 3',
			:city => 'Aars',
			:country => 'Denmark'}
		d2 = Company.first.directors.create(d)

		Company.first.directors.count.should == 2

		# Deleting director d1
		delete "/companies/#{Company.first.id}/directors/#{d1.id}"
		last_response.should be_ok

		# Only one director left
		Company.first.directors.count.should == 1 

		# And its d2
		Company.first.directors.first.name.should == "Jane Doe"

	end
end
