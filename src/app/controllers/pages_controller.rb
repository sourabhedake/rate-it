class PagesController < ApplicationController
	def show
		render template: "pages/#{params[:page]}"
		@query=params[:query]
	end
end
