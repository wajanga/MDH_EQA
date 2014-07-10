class Facility < ActiveRecord::Base
  #require 'csv'
  require 'roo'

	belongs_to :district
	belongs_to :facility_type
	has_many :sent_samples, dependent: :destroy
	has_many :results, dependent: :destroy
  has_many :eqa_tests, -> { uniq }, through: :sent_samples

	validates :name,  presence: true
  validates :facility_type_id, presence: true
  validates :district_id, presence: true
  validates :facility_no,  presence: true, uniqueness: true

  def district_name
  	district.try(:name)
  end

  def facility_type_name
    facility_type.try(:name)
  end

  def district_name=(name)
  	self.district = District.find_by_name(name) if name.present?
  end

  def facility_type_name=(name)
    self.district = FacilityType.find_by_name(name) if name.present?
  end

  filterrific :default_settings => { :sorted_by => 'created_at_desc' }, :filter_names => %w[sorted_by search_query 
    filter_by_test_status with_facility_type_id with_eqa_test_id]

  # default for will_paginate
  self.per_page = 10

  def self.options_for_sorted_by
    [
      ['Name (a-z)', 'name_asc'],
      ['Registration date (newest first)', 'created_at_desc'],
      ['Registration date (oldest first)', 'created_at_asc'],
      ['District (a-z)', 'district_name_asc'],
      ['Facility # (a-z)', 'facility_no_asc']
    ]
  end

  def self.options_for_filter_by_test_status
    [
      ['Done', 'Done'],
      ['Pending', 'Pending']
    ]
  end

  scope :search_query, lambda { |query|
    # Filters facilties whose name matches the query
    return nil  if query.blank?

    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)

    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 2

    joins(:district).where(terms.map { |term|
      "(LOWER(facilities.name) LIKE ? OR LOWER(districts.name) LIKE ?)"
    }.join(' AND '), *terms.map { |e| [e] * num_or_conditions }.flatten)
  }

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      order("facilities.created_at #{ direction }")
    when /^name_/
      order("LOWER(facilities.name) #{ direction }")
    when /^district_name_/
      order("LOWER(districts.name) #{ direction }").includes(:district)
    when /^facility_no_/
      order("LOWER(facilities.facility_no) #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :with_facility_type_id, lambda { |facility_type_ids|
    where(:facility_type_id => [*facility_type_ids])
  }

  scope :with_eqa_test_id, lambda { |eqa_test_id|
    #where(:eqa_test_id => [*eqa_test_ids])
    includes(:results).where(results: {eqa_test_id: eqa_test_id}).references(:results)
  }

  scope :filter_by_test_status, lambda { |filter_option|
    filter_option_string = filter_option.to_s
    if (filter_option_string == 'Done')
      includes(:results).where.not(results: {id: nil}).references(:results)
    elsif (filter_option_string == 'Pending')
      includes(:results).where(results: {id: nil}).references(:results)
    end
  }

  def decorated_created_at
    created_at.to_date.to_s(:long)
  end

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      facility_hash = Hash[[header, spreadsheet.row(i)].transpose]
      
      region = Region.find_or_create_by!(name: facility_hash['region_name'])
      #district = District.create_with(name: facility_hash['district_name']).find_or_create_by!(region_id: region.id)
      district = District.create_with(region_id: region.id).find_or_create_by!(name: facility_hash['district_name'])
      facility_type = FacilityType.find_or_create_by!(name: facility_hash['facility_type_name'])

      facility = Facility.find_or_initialize_by(facility_no: facility_hash["facility_no"])
      facility.name = facility_hash['name']
      facility.district_id = district.id
      facility.facility_type_id = facility_type.id
      facility.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  # def self.import(file)
  #   CSV.foreach(file.path, headers: true) do |row|

  #     facility_hash = row.to_hash

  #     region = Region.find_or_create_by!(name: facility_hash['region_name'])
  #     district = District.create_with(name: facility_hash['district_name']).find_or_create_by!(region_id: region.id)
  #     facility_type = FacilityType.find_or_create_by!(name: facility_hash['facility_type_name'])

  #     facility = Facility.find_or_initialize_by(facility_no: facility_hash["facility_no"])
  #     facility.name = facility_hash['name']
  #     facility.district_id = district.id
  #     facility.facility_type_id = facility_type.id
  #     facility.save!
  #   end
  # end

end