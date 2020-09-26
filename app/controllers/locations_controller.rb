class LocationsController < ApplicationController

  # ---- layout ----
  layout "admin"
  # ---- devise ----
  before_action :authenticate_user!


  def index
    @pagy, @locations = pagy(City.includes(:state, :country).all, items: 10)
  end

end
