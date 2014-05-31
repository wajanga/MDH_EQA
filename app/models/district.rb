class District < ActiveRecord::Base

	belongs_to :region
	has_many :facilities

	validates :name, presence: true
	validates :region_id, presence: true

end
