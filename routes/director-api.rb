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
			# @company.errors.full_messages.to_json
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

		@company = Director.get(Integer(params[:director_id]))

		if @company.update(req_data["director"])
			{ :director => @company }.to_json
		else
			# @company.errors.full_messages.to_json
			halt 422, { :errors => @company.errors.to_h }.to_json
		end

	end
end
