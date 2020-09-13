class FieldMappingsController < BaseController

  # ---- breadcrumbs ----

  add_breadcrumb I18n.t('field_mapping.title'), :collection_path

  # ---- methods ----
  def index
    @supported_tables = supported_tables
    @type = params[:type]
  end

  def show
    add_breadcrumb 'Show', :resource_path
  end

  def supported_tables
    [:passwords, :users, :states, :cities]
  end

end
