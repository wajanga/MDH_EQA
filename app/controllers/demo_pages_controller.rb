class DemoPagesController < ApplicationController
	before_action :signed_in_user

	def home
		@results = Result.order(:created_at).paginate(page: params[:page], per_page: 20)
	end

	def samples
  	end

  	def reports
  		@results = Result.paginate(page: params[:page], per_page: 20)
  	end

end
