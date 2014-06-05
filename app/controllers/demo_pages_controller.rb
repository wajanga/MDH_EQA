class DemoPagesController < ApplicationController
	before_action :signed_in_user

	def home
		@results = Result.paginate(page: params[:page], per_page: 20)
	end

	def samples
  	end

  	def reports
  	end

end
