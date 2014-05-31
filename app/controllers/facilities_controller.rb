class FacilitiesController < ApplicationController

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

  private

    def user_params
      params.require(:facility).permit(:name, :district_name, :facility_type_id)
    end

end
