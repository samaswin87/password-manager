class LocationsController < ApplicationController

  # ---- layout ----
  layout "admin"
  # ---- devise ----
  before_action :authenticate_user!
  before_action :set_location, only: [:destroy, :edit, :show, :update]


  def index
    @search = params[:search]
    if @search
      cities = City.joins(:state, :country)
                   .where('LOWER(cities.name) LIKE ? OR LOWER(states.name) LIKE ? OR LOWER(countries.name) LIKE ?',
                          "%#{@search.downcase}%", "%#{@search.downcase}%", "%#{@search.downcase}%")
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

  def show
    add_breadcrumb 'Show', :locations_path
    @resource = @location.decorate
  end

  def edit
  end

  def update
  end

  private

  def set_location
    @location = City.find(params[:id])
  end

end
