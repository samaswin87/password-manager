class BaseController < InheritedResources::Base

  InheritedResources.flash_keys = [:success, :failure]


  # ---- layout ----

  layout "admin"
  # ---- devise ----

  before_action :authenticate_user!
  load_and_authorize_resource

end
