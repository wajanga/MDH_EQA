class Region < ActiveRecord::Base

	has_many :districts, dependent: :destroy

	validates :name, presence: true
	
end
