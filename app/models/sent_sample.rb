class SentSample < ActiveRecord::Base

	belongs_to :facility
	belongs_to :eqa_test

	@specimen_ids = %w(A1 A2 A3)
	@d_results = %w(REACTIVE NON-REACTIVE)
	@u_results = %w(REACTIVE NON-REACTIVE N/A)
	@f_results = %w(POSITIVE NEGATIVE)

	validates :d_expected_result, inclusion: { in: @d_results, 
		message: "%{value} is not a valid sample result" }
	validates :u_expected_result, inclusion: { in: @u_results, 
		message: "%{value} is not a valid sample result" }
	validates :f_expected_result, inclusion: { in: @f_results, 
		message: "%{value} is not a valid final result" }

	def self.specimen_ids
		[[@specimen_ids[0], @specimen_ids[0]], 
		[@specimen_ids[1], @specimen_ids[1]], 
		[@specimen_ids[2], @specimen_ids[2]]]
  	end

  	def self.d_results
  		[[@d_results[0], @d_results[0]], 
  		[@d_results[1], @d_results[1]], 
  		[@d_results[2], @d_results[2]]]
  	end

  	def self.u_results
  		[[@u_results[0], @u_results[0]], 
  		[@u_results[1], @u_results[1]], 
  		[@u_results[2], @u_results[2]]]
  	end

  	def self.f_results
  		[[@f_results[0], @f_results[0]], 
  		[@f_results[1], @f_results[1]], 
  		[@f_results[2], @f_results[2]]]
  	end

end
