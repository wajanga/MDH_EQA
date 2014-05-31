class ResultsController < ApplicationController

	skip_before_filter :verify_authenticity_token

	respond_to :json

	def create
		respond_with Result.create(result_params)
		#@res = params[:result][:facility_id]
		#render :test_page
	end

	def index
		redirect_to root_path
	end

	private

    	def result_params
      		params.require(:result).permit(:facility_id, :sample_receive_date, :done_by,
      			:assay1_no, :assay2_no, :approved_by, :test_done_date, :assay1_expiry_date,
      			:assay2_expiry_date, :result_received_date, :sample_results)
    	end

end
