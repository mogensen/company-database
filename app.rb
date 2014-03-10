# Require the bundler gem and then call Bundler.require to load in all gems
# listed in Gemfile.
require 'bundler'
Bundler.require

# Setup DataMapper with a database URL. On Heroku, ENV['DATABASE_URL'] will be
# set, when working locally this line will fall back to using SQLite in the
# current directory.
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite")

# Define a simple DataMapper model.
class Company
	include DataMapper::Resource

	property :id,         Serial,  :key => true
	property :created_at, DateTime
	property :updated_at, DateTime
	property :name,       String,  :length => 255
	property :address,    Text
	property :city,       String,  :length => 255
	property :country,    String,  :length => 255
	property :email,      String,  :length => 255
	property :phone,      String,  :length => 255
	property :avatar_url, String,  :length => 255

	has n, :directors
	has n, :owners

	is_versioned :on => :updated_at

	before(:save) { self.updated_at = Time.now }

end

class Director
	include DataMapper::Resource

	property :id,         Serial,  :key => true
	property :created_at, DateTime
	property :updated_at, DateTime
	property :name,       String,  :length => 255
	property :address,    Text
	property :city,       String,  :length => 255
	property :country,    String,  :length => 255
	property :email,      String,  :length => 255
	property :phone,      String,  :length => 255

	belongs_to :company
	validates_presence_of :company, :message => "cannot be empty"
end

class Owner
	include DataMapper::Resource

	property :id,         Serial,  :key => true
	property :created_at, DateTime
	property :updated_at, DateTime
	property :name,       String,  :length => 255
	property :address,    Text
	property :city,       String,  :length => 255
	property :country,    String,  :length => 255
	property :email,      String,  :length => 255
	property :phone,      String,  :length => 255

	belongs_to :company
	validates_presence_of :company, :message => "cannot be empty"
end

# Finalize the DataMapper models.
DataMapper.finalize

# Tell DataMapper to update the database according to the definitions above.
DataMapper.auto_upgrade!


helpers do
  def company
    @company ||= Company.get(Integer(params[:company_id])) || halt(404)
  end

  def director
    @director ||= company.directors.find(params[:director_id]) || halt(404)
  end
end





get '/' do
	erb :index
end

# Route to show all companies, ordered like a blog
get '/companies' do
	content_type :json
	@companies = Company.all()

	{ :companies => @companies }.to_json
end

# CREATE: Route to create a new Company
post '/companies' do
	content_type :json

	# JSON is sent in the body of the http request.
	# We need to parse the body from a string into JSON
	params_json = JSON.parse(request.body.read)

	@company = Company.new(params_json["company"])

	if @company.save
		{ :company => @company }.to_json
	else
		halt 500
	end
end

# READ: Route to show a specific Company based on its `id`
get '/companies/:company_id' do
	content_type :json

	{ :company => company, :versions => company.versions[0..4]}.to_json
end

# UPDATE: Route to update a Company
put '/companies/:company_id' do
	content_type :json

	# JSON is sent in the body of the http request.
	# We need to parse the body from a string into JSON
	params_json = JSON.parse(request.body.read)

	company.update(params_json["company"])
	company.to_json

end

# DELETE: Route to delete a Company
delete '/companies/:id' do
	content_type :json
	@company = Company.get(Integer(params[:id]))

	{ :url => "/companies"}

	if ! @company.destroy
		halt 500
	end
end

not_found do
  'This is nowhere to be found.'
  #erb :'404'
  halt 404
end

# If there are no companies in the database, add a few.
if Company.count == 0
	Company.create(:name => "Test Company One", :address => "Langelandsgade 9")
	Company.create(:name => "Test Company Two", :address => "Ny Munkegade 16")
end
