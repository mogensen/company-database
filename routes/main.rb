class CompanyDatabase < Sinatra::Application

	get '/' do
		erb :index
	end
end
