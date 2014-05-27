require 'spec_helper'

describe FacilityType do
  
	before do
    	@facility_type = FacilityType.new(name: "Lab")
  	end

  	subject { @facility_type }

  	it { should respond_to(:name) }

  	it { should be_valid }

end
