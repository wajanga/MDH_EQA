require 'spec_helper'

describe SentSample do

	let(:sent_sample) { FactoryGirl.create(:sent_sample) }

	subject { sent_sample }

	it { should respond_to(:specimen_id) }
  	it { should respond_to(:d_expected_result) }
  	it { should respond_to(:u_expected_result) }
  	it { should respond_to(:f_expected_result) }

  	it { should be_valid }

  	describe "when determine expected result is not the right format" do
    	before { sent_sample.d_expected_result = "gibberish" }
    	it { should_not be_valid }
  	end

  	describe "when determine expected result is the right format - REACTIVE" do
    	before { sent_sample.d_expected_result = "REACTIVE" }
    	it { should be_valid }
  	end

  	describe "when determine expected result is the right format - NON-REACTIVE" do
    	before { sent_sample.d_expected_result = "NON-REACTIVE" }
    	it { should be_valid }
  	end

  	describe "when unigold expected result is not the right format" do
    	before { sent_sample.u_expected_result = "yellow" }
    	it { should_not be_valid }
  	end

  	describe "when final expected result is not the right format" do
    	before { sent_sample.f_expected_result = "whatsapp" }
    	it { should_not be_valid }
  	end

end
