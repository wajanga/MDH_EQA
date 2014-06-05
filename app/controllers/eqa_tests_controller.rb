class EqaTestsController < ApplicationController
  before_action :signed_in_user

	def index
    	@eqas = EqaTest.paginate(page: params[:page])
  	end

  	def new
  		if EqaTest.where("start_date <= :date AND end_date >= :date", date: Date.today).exists?
  			flash[:error] = 'EQA already in progress'
  			redirect_to eqa_tests_url
  		else	
  		end
  	end

end
