require 'spec_helper'

describe "ResultsApis" do

  describe "POST /results" do
  	it "creates a movie" do
    	result_params = {"result" => {"facility_id"=>1, "sample_receive_date"=>"2014-05-20", "done_by"=>"AWK", "assay1_no"=>"455",
    	 "assay2_no"=>"455", "approved_by"=>"AWK", "test_done_date"=>"2014-05-20", "assay1_expiry_date"=>"2014-05-20", 
    	 "assay2_expiry_date"=>"2014-05-20", "result_received_date"=>"2014-05-20", "sample_results"=>[{"specimen_id"=>"A1", 
    	 	"d_result"=>"REACTIVE", "u_result"=>"REACTIVE", "f_result"=>"POSITIVE"}, 
    	 	{"specimen_id"=>"A2", "d_result"=>"NON-REACTIVE", "u_result"=>"N/A", "f_result"=>"NEGATIVE"}, 
    	 	{"specimen_id"=>"A3", "d_result"=>"NON-REACTIVE", "u_result"=>"N/A", "f_result"=>"NEGATIVE"}]}}.to_json

    	request_headers = {
            "Accept" => "application/json",
        	"Content-Type" => "application/json"
    	}

    	post results_path, result_params, request_headers

    	#expect(response.body).to include("123")
        expect(response.status).to eq 201 # created
        expect(Result.first.facility_id).to eq 1
        #expect(Result.first.facility).to eq "Mwananyamala Regional Hospital"
    end
  end

end
