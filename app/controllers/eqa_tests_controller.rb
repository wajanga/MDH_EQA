class EqaTestsController < ApplicationController
  before_action :signed_in_user
  before_action :compare_dates, only: :create

	def index
    @eqas = EqaTest.paginate(page: params[:page])
  end

  def new
  	if EqaTest.where("start_date <= :date AND end_date >= :date", date: Date.today).exists?
  		flash[:error] = 'EQA already in progress'
  		redirect_to eqa_tests_url
  	else
      @eqa_test = EqaTest.new
      3.times { @eqa_test.eqa_samples.build}
  	end
  end

  def create
    @eqa_test = EqaTest.new(eqa_params)
    begin
      if @eqa_test.save
        flash[:success] = "EQA #{@eqa_test.eqa_number} has been created successfully"
        redirect_to eqa_tests_url
      else
        render 'new'
      end
    rescue ActiveRecord::RecordNotUnique
      flash.now[:error] = 'Specimen IDs must be different'
      render 'new'
    end
  end

  def edit
    @eqa_test = EqaTest.find(params[:id])
  end

  def update
    @eqa_test = EqaTest.find(params[:id])
    if @eqa_test.update_attributes(eqa_params)
      flash[:success] = "EQA updated"
      redirect_to eqa_tests_path
    else
      render 'edit'
    end
  end

  def destroy
      EqaTest.find(params[:id]).destroy
      flash[:success] = "EQA deleted"
      redirect_to eqa_tests_path
  end

  private

  def eqa_params
    params.require(:eqa_test).permit(:eqa_number, :start_date, :end_date, 
      eqa_samples_attributes: [:id, :specimen_id, :d_expected_result, :u_expected_result, :f_expected_result])
  end

  # Before filters

  def compare_dates
    unless eqa_params[:end_date] >= eqa_params[:start_date]
      flash[:error] = "End date is must be greater start date"
      redirect_to new_eqa_test_url
    end
  end

end
