class Result < ActiveRecord::Base

	belongs_to :facility
	belongs_to :eqa_test
	has_many :sample_results, dependent: :destroy
	validates :facility_id, uniqueness: {scope: :eqa_test_id}

end
