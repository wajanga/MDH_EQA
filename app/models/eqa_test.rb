class EqaTest < ActiveRecord::Base

	has_many :sent_samples
	has_many :eqa_samples, dependent: :destroy
	has_many :results
	has_many :facilities, -> { uniq }, through: :sent_samples

	validates :eqa_number, :start_date, :end_date, presence: true
	validates_associated :eqa_samples
	validates :eqa_number, uniqueness: true

	accepts_nested_attributes_for :eqa_samples, allow_destroy: true

	def self.options_for_select
  		order('eqa_number').map { |e| [e.eqa_number, e.id] }
	end

end
