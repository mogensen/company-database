require 'spec_helper.rb'

describe 'Internally' do

	before(:each) do
		# cleanup database
		Director.all.destroy
		Company.all.destroy
	end

	it "should be able to add directors" do
		Company.count.should == 0
		Director.count.should == 0

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

		c1.directors.count.should == 1

		c1.save

		# New Director is saved to DB
		Director.count.should == 1

		c1.directors.first.name.should == 'Peter'
		c1.directors.first.city.should == 'Aars'
	end

	it "should return 404 if page does not exist" do

		get "/itAintHere"
		last_response.status.should eql 404

		get "/thisAintEither"
		last_response.status.should eql 404
	end

end
