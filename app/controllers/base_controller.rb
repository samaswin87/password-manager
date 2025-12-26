class BaseController < InheritedResources::Base
  InheritedResources.flash_keys = %i[success failure]

  # ---- layout ----

  layout 'admin'
  # ---- devise ----

  before_action :authenticate_user!
  load_and_authorize_resource

  protected

  def csv_options
    { force_utf8: true, convert_values_to_numeric: true }
  end
end
