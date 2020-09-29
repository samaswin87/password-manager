class LocationsController < ApplicationController

  # ---- layout ----
  layout "admin"
  # ---- devise ----
  before_action :authenticate_user!
  before_action :set_location, only: [:destroy, :edit, :show, :update]

  add_breadcrumb 'Locations', :locations_path


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
    add_breadcrumb 'Show', :location_path
    @resource = @location.decorate
  end

  def edit
    @countries = Country.valid.pluck(:id, :name, :alias)
    @states = State.valid.pluck(:id, :name)
    @cities = City.valid.pluck(:id, :name)
  end

  def update
  end

  private

  def set_location
    @location = City.find(params[:id])
  end

end
