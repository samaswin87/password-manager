class LocationsController < ApplicationController
  # ---- layout ----
  layout 'admin'
  # ---- devise ----
  before_action :authenticate_user!
  before_action :set_location, only: [:destroy]

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

  def show
    add_breadcrumb 'Show', :location_path
    @resource = @location.decorate
  end

  def new; end

  def create
    LocationService.call(location_params)
    redirect_to locations_path
  end

  def destroy
    if @location.addresses.none?
      @location.destroy
      flash[:notice] = 'Location removed'
    else
      flash[:alert] = 'You can not delete the location'
    end
    redirect_to locations_path
  end

  def countries
    countries = Country.valid
    if params[:type] == 'name'
      countries = countries.map do |country|
        {
          id: country.id,
          text: country.name
        }
      end
    elsif params[:type] == 'alias'
      countries = countries.map do |country|
        {
          id: country.id,
          text: country.alias
        }
      end
    end

    render json: { records: countries }, status: HTTP::OK and return
  end

  def states
    states = State.valid
    states = states.map do |state|
      {
        id: state.id,
        text: state.name
      }
    end
    render json: { records: states }, status: HTTP::OK and return
  end

  def cities
    cities = City.valid
    cities = cities.map do |city|
      {
        id: city.id,
        text: city.name
      }
    end
    render json: { records: cities }, status: HTTP::OK and return
  end

  private

  def set_location
    @location = City.find(params[:id])
  end

  def location_params
    params.permit(:country_name, :country_alias, :state_name, :city_name)
  end
end
