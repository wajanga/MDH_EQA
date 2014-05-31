class FacilityType < ActiveRecord::Base

	has_many :facilities

	validates :name, presence: true

end
