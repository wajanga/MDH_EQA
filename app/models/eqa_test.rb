class EqaTest < ActiveRecord::Base

	has_many :sent_samples
	has_many :results
	has_many :facilities, -> { uniq }, through: :sent_samples

end
