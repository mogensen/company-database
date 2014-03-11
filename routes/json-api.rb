class CompanyDatabase < Sinatra::Application

	helpers do
		def req_data
			# JSON is sent in the body of the http request.
			# We need to parse the body from a string into JSON
			@req_data ||= JSON.parse(request.body.read)
		end
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

		@company = Company.new(req_data['company'])
		

		if @company.save
			{ :company => @company }.to_json
		else
			# @company.errors.full_messages.to_json
			halt 422, { :errors => @company.errors.to_h }.to_json
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

		@company = Company.get(Integer(params[:company_id]))

		if @company.update(req_data["company"])
			{ :company => @company }.to_json
		else
			# @company.errors.full_messages.to_json
			halt 422, { :errors => @company.errors.to_h }.to_json
		end

	end

	# DELETE: Route to delete a Company
	delete '/companies/:company_id' do
		content_type :json
		@company = Company.get(Integer(params[:company_id]))

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
end
