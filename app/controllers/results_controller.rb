class ResultsController < ApplicationController

	skip_before_filter :verify_authenticity_token

	respond_to :json

	def create
		parse_json
		@res = Result.new(@result_hash)
		@res.facility_id = Facility.find_by(facility_no: @facility_no[:facility_id]).id
		@res.eqa_test_id = EqaTest.where("start_date < ? AND end_date > ?", 
			@result_hash[:result_received_date], @result_hash[:result_received_date]).first.id
		#@res.sample_results.build(@samples_hash)

		if @res.save
			respond_with @res
		end
	end

	def index
		redirect_to root_path
	end

	private

    	def parse_json
      		@result_hash = params.require(:result).permit(:sample_receive_date, :done_by,
      			:assay1_no, :assay2_no, :approved_by, :test_done_date, :assay1_expiry_date,
      			:assay2_expiry_date, :result_received_date)
      		@samples_hash = params.require(:result).permit(:sample_results)
      		@facility_no = params.require(:result).permit(:facility_id)
    	end

end
