class SampleResult < ActiveRecord::Base

	belongs_to :result

	validates :d_result, inclusion: { in: %w(REACTIVE NON-REACTIVE), 
		message: "%{value} is not a valid sample result" }
	validates :u_result, inclusion: { in: %w(REACTIVE NON-REACTIVE N/A), 
		message: "%{value} is not a valid sample result" }
	validates :f_result, inclusion: { in: %w(POSITIVE NEGATIVE), 
		message: "%{value} is not a valid final result" }

end
