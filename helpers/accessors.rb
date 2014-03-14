helpers do
	def company
		@company ||= Company.get(Integer(params[:company_id])) || halt(404)
	end

	def director
		@director ||= Director.get(Integer(params[:director_id])) || halt(404)
	end
end
