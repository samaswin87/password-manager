class LocationsController < ApplicationController

  # ---- layout ----
  layout "admin"
  # ---- devise ----
  before_action :authenticate_user!


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

end
