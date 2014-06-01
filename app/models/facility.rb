class Facility < ActiveRecord::Base

	belongs_to :district
	belongs_to :facility_type
	has_many :sent_samples, dependent: :destroy
	has_many :results, dependent: :destroy

	validates :name,  presence: true
  validates :facility_type_id, presence: true
  validates :district_id, presence: true
  validates :facility_no,  presence: true

  def district_name
  	district.try(:name)
  end

  def district_name=(name)
  	self.district = District.find_by_name(name) if name.present?
  end

end
