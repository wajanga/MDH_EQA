class FacilitiesController < ApplicationController
  before_action :signed_in_user

  autocomplete :district, :name

  def index
    @filterrific = Filterrific.new(Facility, params[:filterrific] || session[:filterrific_facilities])
    @filterrific.select_options = { sorted_by: Facility.options_for_sorted_by, with_district_id: District.options_for_select }

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

	def show
    @facility = Facility.find(params[:id])
  end

  def new
  	@facility = Facility.new
  end

  def create
  	district = District.find_by(name: params[:facility][:district_name])
    @facility = Facility.new(name: params[:facility][:name], district_id: district.id, facility_type_id: params[:facility][:facility_type_id])
    if @facility.save
      		
    else
      render 'new'
    end
  end

  def new_sample
    #@facility = Facility.find(params[:id])
    if @samples = SentSample.where(facility_id: params[:id], eqa_test_id: 1).exists?
      flash[:error] = 'Sample already sent'
    else
      @samples = SentSample.where(facility_id: 1, eqa_test_id: 1)
      @samples.each { |sample|  
        new_sample = sample.dup
        new_sample.facility_id = params[:id]
        new_sample.save
      }
    end
    redirect_to facility_url(params[:id])
  end

  private

    def user_params
      params.require(:facility).permit(:name, :district_name, :facility_type_id)
    end

end
