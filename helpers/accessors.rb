helpers do
	def company
		@company ||= Company.get(Integer(params[:company_id])) || halt(404)
	end

	def director
		@director ||= company.directors.find(params[:director_id]) || halt(404)
	end
end
