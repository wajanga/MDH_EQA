class Result < ActiveRecord::Base

	belongs_to :facility
	belongs_to :eqa_test
	has_many :sample_results, dependent: :destroy
	validates :facility_id, uniqueness: {scope: :eqa_test_id}

	def calculate_score
    	sc = 10

    	sent_samples = SentSample.where(facility_id: self.facility_id, eqa_test_id: self.eqa_test_id)
    	return sc if sent_samples.blank?

    	unless self.sample_results.empty?
    		sent_samples.each { |sample|
    			result_sample = self.sample_results.where(specimen_id: sample.specimen_id).take

    			sc += 10 if (result_sample.d_expected_result == sample.d_expected_result)
    			sc += 10 if (result_sample.u_expected_result == sample.u_expected_result)
    			sc += 10 if (result_sample.f_expected_result == sample.f_expected_result)
      		}
      	end
      	return sc
    end

end
