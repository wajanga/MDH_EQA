class DemoPagesController < ApplicationController
	before_action :signed_in_user

	def home
		@results = Result.all
	end

end
