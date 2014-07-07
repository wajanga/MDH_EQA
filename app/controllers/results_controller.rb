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

		# Find facility in DB using the supplied facility number
		facility = Facility.find_by(facility_no: @result_hash[:facility_id])

		# Return error if facility is not found
		return render :json => { :errors => ["Facility does not exist"] }, :status => 404 if facility.nil?

		@res.facility_id = facility.id
		eqa_test = EqaTest.where("start_date <= ? AND end_date >= ?", 
			@result_hash[:result_received_date], @result_hash[:result_received_date])
		return render :json => { :errors => ["There is no active EQA"] }, :status => 405 if eqa_test.blank?

		@res.eqa_test_id = eqa_test.take.id

		@res.score = calculate_score(@res.facility_id, @res.eqa_test_id) # calculate the score

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

	def check_facility
		facility_request_hash = parse_facility_request
		facility = Facility.find_by(facility_no: facility_request_hash[:facility_id])
		if facility.blank?
			return render :json => { :error => "Facility does not exist" }, :status => 404
		else
			return render :json => { :name => "#{facility.name}" }, :status => 200
		end
	end

	private

    	def parse_json
      		@result_hash = params.require(:result).permit(:facility_id, :sample_receive_date, :done_by,
      			:assay1_no, :assay2_no, :approved_by, :test_done_date, :assay1_expiry_date,
      			:assay2_expiry_date, :result_received_date)
      		@samples_hash = params.require(:result).permit(sample_results: [:specimen_id, :d_result, :u_result, :f_result])
    	end

    	def parse_facility_request
    		params.require(:request).permit(:facility_id)
    	end

    	def calculate_score(facility_id, eqa_test_id)
    		score = 10
    		sent_samples = SentSample.where(facility_id: facility_id, eqa_test_id: eqa_test_id)
    		sent_samples.each { |sample|
    			result_sample = @samples_hash[:sample_results].select {|i| i.has_value?(sample.specimen_id)}[0]
    			score += 10 if (result_sample[:d_result] == sample.d_expected_result)
    			score += 10 if (result_sample[:u_result] == sample.u_expected_result)
    			score += 10 if (result_sample[:f_result] == sample.f_expected_result)
      		}
      		return score
    	end

end
