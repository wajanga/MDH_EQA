require 'spec_helper'

describe "Results Apis" do

  describe "POST /results" do
    let(:result_params) do 
        {"result" => {"facility_id"=>123, "sample_receive_date"=>"2014-05-20", "done_by"=>"AWK", "assay1_no"=>"455",
         "assay2_no"=>"455", "approved_by"=>"AWK", "test_done_date"=>"2014-05-20", "assay1_expiry_date"=>"2014-05-20", 
         "assay2_expiry_date"=>"2014-05-20", "result_received_date"=>"2014-05-20", "sample_results"=>[{"specimen_id"=>"A1", 
            "d_result"=>"REACTIVE", "u_result"=>"REACTIVE", "f_result"=>"POSITIVE"}, 
            {"specimen_id"=>"A2", "d_result"=>"NON-REACTIVE", "u_result"=>"N/A", "f_result"=>"NEGATIVE"}, 
            {"specimen_id"=>"A3", "d_result"=>"NON-REACTIVE", "u_result"=>"N/A", "f_result"=>"NEGATIVE"}]}}
    end
    let(:request_headers) do
        request_headers = {
            "Accept" => "application/json",
            "Content-Type" => "application/json"
        }
    end

    before do
        FactoryGirl.create(:facility)
        FactoryGirl.create(:eqa_test)
        FactoryGirl.create(:sent_sample)
        FactoryGirl.create(:sent_sample, specimen_id: "A2", 
            d_expected_result: "NON-REACTIVE", u_expected_result: "N/A", f_expected_result: "NEGATIVE")
        FactoryGirl.create(:sent_sample, specimen_id: "A3", 
            d_expected_result: "NON-REACTIVE", u_expected_result: "N/A", f_expected_result: "NEGATIVE")
    end

  	it "creates a result" do
    	result_params_json = result_params.to_json
    	post results_path, result_params_json, request_headers

        expect(response.status).to eq 201 # created
        expect(Result.first.facility_id).to eq 1
        expect(Result.first.eqa_test_id).to eq 1
        expect(Result.count).to eq 1
        expect(SampleResult.count).to eq 3
    end

    it "submits a result with a non-existant facility" do
        result_params["result"]["facility_id"] = 999
        result_params_json = result_params.to_json
        post results_path, result_params_json, request_headers

        expect(response.status).to eq 404

        body = JSON.parse(response.body)
        expect(body['errors']).to eq(["Facility does not exist"])
    end

    describe "calculates the correct score" do
        it "of 90" do
            result_params["result"]["sample_results"][0]["f_result"] = "NEGATIVE"
            result_params_json = result_params.to_json
            post results_path, result_params_json, request_headers
            expect(Result.first.score).to eq 90
        end

        it "of 80" do
            result_params["result"]["sample_results"][0]["d_result"] = "NON-REACTIVE"
            result_params["result"]["sample_results"][0]["u_result"] = "N/A"
            result_params_json = result_params.to_json
            post results_path, result_params_json, request_headers
            expect(Result.first.score).to eq 80
        end

        it "of 70" do
            result_params["result"]["sample_results"][0]["d_result"] = "NON-REACTIVE"
            result_params["result"]["sample_results"][0]["u_result"] = "N/A"
            result_params["result"]["sample_results"][0]["f_result"] = "NEGATIVE"
            result_params_json = result_params.to_json
            post results_path, result_params_json, request_headers
            expect(Result.first.score).to eq 70
        end
    end
  end

end
