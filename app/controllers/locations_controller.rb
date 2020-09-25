class LocationsController < ApplicationController

  # ---- layout ----
  layout "admin"
  # ---- devise ----
  before_action :authenticate_user!


  def index
  end
end
