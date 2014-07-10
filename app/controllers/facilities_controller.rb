class FacilitiesController < ApplicationController
  before_action :signed_in_user

  autocomplete :district, :name

  def index
    #@facilities = Facility.paginate(page: params[:page], per_page: 10)
    @filterrific = Filterrific.new(Facility, params[:filterrific] || session[:filterrific_facilities])

    @facilities = Facility.filterrific_find(@filterrific).page(params[:page])

    session[:filterrific_facilities] = @filterrific.to_hash

    respond_to do |format|
      format.html
      format.js
    end
  end

	def show
    @facility = Facility.find(params[:id])
  end

  def edit
    @facility = Facility.find(params[:id])
  end

  def update
    @facility = Facility.find(params[:id])
    if @facility.update_attributes(facility_params)
      flash[:success] = "Facility updated successfully"
      redirect_to facilities_path
    else
      render 'edit'
    end
  end

  def new
  	@facility = Facility.new
  end

  def create
  	district = District.find_by(name: facility_params[:district_name])
    if (district.blank?)
      # Do something
    else
      @facility = Facility.new(name: facility_params[:name], 
        district_id: district.id, facility_type_id: facility_params[:facility_type_id], 
        facility_no: facility_params[:facility_no])
    end
    if @facility.save
      flash[:success] = "Facility #{@facility.name} has been created successfully"
      redirect_to facilities_url	
    else
      render 'new'
    end
  end

  def new_sample
    eqa_test = EqaTest.find_by("start_date <= :date AND end_date >= :date", date: Date.today)
    if eqa_test.blank?
      flash[:error] = 'There is currently no active EQA. Please create one first.'
    else
      if @samples = SentSample.where(facility_id: params[:id], eqa_test_id: eqa_test.id).exists?
        flash[:error] = 'Sample already sent for the current EQA'
      else
        @samples = eqa_test.eqa_samples
        @samples.each { |sample|
          new_sent_sample = SentSample.new
          new_sent_sample.attributes = sample.attributes.except('id')
          new_sent_sample.facility_id = params[:id]
          new_sent_sample.save
        }
        result = Result.find_by(facility_id: params[:id], eqa_test_id: eqa_test.id)
        unless result.blank?
          result.score = result.calculate_score
          result.save
        end
      end
    end
    #redirect_to facility_url(params[:id])
    redirect_to facility_path(params[:id])
  end

  def destroy
    Facility.find(params[:id]).destroy
    flash[:success] = "Facility deleted successfully"
    redirect_to facilities_path
  end

  def import
    begin
      Facility.import(params[:file])
      flash[:success] = "Facilities imported successfully"
      redirect_to facilities_url
    rescue 
      flash[:error] = "Facilities could not be imported. Invalid CSV file format"
      redirect_to facilities_url
    end
  end

  def reset_filterrific
    # Clear session persistence
    session[:filterrific_facilities] = nil
    # Redirect back to the index action for default filter settings.
    redirect_to :action => :index
  end

  private

    def facility_params
      params.require(:facility).permit(:name, :district_name, :facility_type_id, :facility_no)
    end

end
