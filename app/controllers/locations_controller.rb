class LocationsController < ApplicationController

  # ---- layout ----
  layout "admin"
  # ---- devise ----
  before_action :authenticate_user!
  before_action :set_location, only: [:destroy]


  def index
    @search = params[:search]
    if @search
      cities = City.joins(:state, :country)
                   .where('cities.name LIKE ? OR states.name LIKE ? OR countries.name LIKE ?', "%#{@search}%", "%#{@search}%", "%#{@search}%")
      @pagy, @locations = pagy(cities, items: 10)
    else
      @pagy, @locations = pagy(City.includes(:state, :country).all, items: 10)
    end
  end

  def destroy
    if @location.addresses.count == 0
      @location.destroy
      flash[:notice] = "Location removed"
    else
      flash[:alert] = "You can not delete the location"
    end
    redirect_to locations_path
  end

  private

  def set_location
    @location = City.find(params[:id])
  end

end
