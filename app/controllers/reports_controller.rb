class ReportsController < ApplicationController
	before_action :signed_in_user

	def index
    	@filterrific = Filterrific.new(Facility, params[:filterrific] || session[:filterrific_facilities])
    	@filterrific.select_options = { sorted_by: Facility.options_for_sorted_by, 
    		filter_by_test_status: Facility.options_for_filter_by_test_status, 
    		with_facility_type_id: FacilityType.options_for_select, 
    		with_eqa_test_id: EqaTest.options_for_select }

    	@facilities = Facility.filterrific_find(@filterrific).page(params[:page])

    	session[:filterrific_facilities] = @filterrific.to_hash

    	respond_to do |format|
      		format.html
      		format.js
    	end
  	end

  	def reset_filterrific
    	# Clear session persistence
    	session[:filterrific_facilities] = nil
    	# Redirect back to the index action for default filter settings.
    	redirect_to :action => :index
  	end
end
