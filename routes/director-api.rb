class CompanyDatabase < Sinatra::Application

	# READ: Route to show a specific Company based on its `id`
	get '/companies/:company_id/directors' do
		content_type :json

		{ :directors => company.directors}.to_json
	end

	# CREATE: Route to create a new Director
	post '/companies/:company_id/directors' do
		content_type :json

		@director = Director.new(req_data['director'])
		@director.company = company



		if @director.save
			company.directors.push(@director)
			{ :director => @director }.to_json
		else
			halt 422, { :errors => @director.errors.to_h }.to_json
		end
	end

	# READ: Route to show a specific Company based on its `id`
	get '/companies/:company_id/directors/:director_id' do
		content_type :json

		{ :director => director}.to_json
	end

	# UPDATE: Route to update a dirctor in a Company
	put '/companies/:company_id/directors/:director_id' do
		content_type :json

		@director = Director.get(Integer(params[:director_id]))

		begin
			@director.update(req_data["director"])
		rescue Exception=>e
			error = e.message
			# 422 Unprocessable Entity (WebDAV; RFC 4918)
			# The request was well-formed but was unable to be followed due to semantic errors.
			halt 422, { :errors => error }.to_json
		end
		{ :director => @director }.to_json
	end

	# DELETE: Route to delete a Director
	delete '/companies/:company_id/directors/:director_id' do
		content_type :json

		{ :url => "/companies/#{company.id}/directors"}

		if ! director.destroy
			halt 500
		end
	end

end
