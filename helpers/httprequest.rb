class CompanyDatabase < Sinatra::Application

	helpers do
		def req_data
			# JSON is sent in the body of the http request.
			# We need to parse the body from a string into JSON
			@req_data ||= JSON.parse(request.body.read)
		end
	end
end
