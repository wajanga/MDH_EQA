class FacilityType < ActiveRecord::Base

	has_many :facilities

	validates :name, presence: true

	@fac_types = %w(LAB PMTCT PICT VCT TB-HIV)

	def self.options_for_select
  		order('LOWER(name)').map { |e| [e.name, e.id] }
	end

end
