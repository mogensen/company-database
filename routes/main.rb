class CompanyDatabase < Sinatra::Application

	get '/' do
		erb :index
	end

	not_found do
		'This is nowhere to be found.'
		#erb :'404'
		halt 404
	end

end
