class CompanyDatabase < Sinatra::Application

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
			# 422 Unprocessable Entity (WebDAV; RFC 4918)
			# The request was well-formed but was unable to be followed due to semantic errors.
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

		begin
			@company.update(req_data["company"])
		rescue Exception=>e
			error = e.message
			# 422 Unprocessable Entity (WebDAV; RFC 4918)
			# The request was well-formed but was unable to be followed due to semantic errors.
			halt 422, { :errors => error }.to_json
		end

		{ :company => @company }.to_json

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

end
