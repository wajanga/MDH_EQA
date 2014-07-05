require 'spec_helper'

describe "Eqa gages" do

	subject { page }

	describe "All EQAs page" do
		#before { visit eqa_tests_path }
		let(:user) { FactoryGirl.create(:user) }
		before :each do
			sign_in user
			visit eqa_tests_path
		end

		it { should have_content('All EQAs') }
		it { should have_content('There are currently no registered EQAs') }
	end

end