class FacilitiesController < ApplicationController
  before_action :signed_in_user

  autocomplete :district, :name

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
