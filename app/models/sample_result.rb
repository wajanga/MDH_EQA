class SampleResult < ActiveRecord::Base

	belongs_to :result

	validates :d_result, inclusion: { in: %w(REACTIVE NON-REACTIVE POSITIVE), 
		message: "%{value} is not a valid sample result" }
	validates :u_result, inclusion: { in: %w(REACTIVE NON-REACTIVE N/A POSITIVE), 
		message: "%{value} is not a valid sample result" }
	validates :f_result, inclusion: { in: %w(POSITIVE NEGATIVE UNDETERMINED), 
		message: "%{value} is not a valid final result" }

end
