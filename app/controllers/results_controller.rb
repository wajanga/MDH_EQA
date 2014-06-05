class ResultsController < ApplicationController

	skip_before_filter :verify_authenticity_token

	respond_to :json, :html

	def show
		@result = Result.find_by(facility_id: params[:fac], eqa_test_id: params[:eqa])
		@facility = Facility.find_by(id: params[:fac])
		@eqa = EqaTest.find_by(id: params[:eqa])
	end

	def create
		parse_json
		@res = Result.new(@result_hash)
		@res.facility_id = Facility.find_by(facility_no: @result_hash[:facility_id]).id
		@res.eqa_test_id = EqaTest.where("start_date < ? AND end_date > ?", 
			@result_hash[:result_received_date], @result_hash[:result_received_date]).first.id
		@res.sample_results.build(@samples_hash[:sample_results])

		if @res.save
			respond_with @res
		else
			render :json => { :errors => @res.errors.full_messages }, :status => 422
		end
	end

	def index
		redirect_to root_path
	end

	private

    	def parse_json
      		@result_hash = params.require(:result).permit(:facility_id, :sample_receive_date, :done_by,
      			:assay1_no, :assay2_no, :approved_by, :test_done_date, :assay1_expiry_date,
      			:assay2_expiry_date, :result_received_date)
      		@samples_hash = params.require(:result).permit(sample_results: [:specimen_id, :d_result, :u_result, :f_result])
    	end

end
