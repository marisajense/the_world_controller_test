class CountriesController < ApplicationController
  before_action :country, except: [:index, :new, :create]

  def index
    @countries = Country.all.limit(2)
  end

  def new
    @country = Country.new
  end

  def create
    @country = Country.new(country_params)
    if @country.save
      flash[:success] = "Country Created!"
      redirect_to country_path(@country)
    else
      flash[:error] = "Fix errors and try again"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @country.update(country_params)
      flash[:success] = "Country Updated!"
      redirect_to country_path(@country)
    else
      flash[:error] = "Country failed to update"
      render :edit
    end
  end

  def destroy
    @country.destroy
    flash[:success] = "Country deleted!"
    redirect_to countries_path
  end

  private
  def country
    @country = Country.find(params[:id])
  end

  def country_params
    params.require(:country).permit(:name, :population, :language)
  end

end
