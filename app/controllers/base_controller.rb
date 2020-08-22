class BaseController < InheritedResources::Base

  InheritedResources.flash_keys = [:success, :failure]


  # ---- layout ----

  layout :resolve_layout
  # ---- devise ----

  before_action :authenticate_user!
  load_and_authorize_resource


  private

  def resolve_layout
    case action_name
    when "index"
      "admin_table"
    else
      "admin"
    end
  end
end
