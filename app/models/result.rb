class Result < ActiveRecord::Base

	belongs_to :facility
	belongs_to :eqa_test
	has_many :sample_results, dependent: :destroy

end
