class SentSample < ActiveRecord::Base

	belongs_to :facility
	belongs_to :eqa_test

	validates :d_expected_result, inclusion: { in: %w(REACTIVE NON-REACTIVE), 
		message: "%{value} is not a valid sample result" }
	validates :u_expected_result, inclusion: { in: %w(REACTIVE NON-REACTIVE N/A), 
		message: "%{value} is not a valid sample result" }
	validates :f_expected_result, inclusion: { in: %w(POSITIVE NEGATIVE), 
		message: "%{value} is not a valid final result" }

end
