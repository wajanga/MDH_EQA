class District < ActiveRecord::Base

	belongs_to :region
	has_many :facilities

	validates :name, presence: true
	validates :region_id, presence: true

	def self.options_for_select
  		order('LOWER(name)').map { |e| [e.name, e.id] }
	end

end
