class FieldMappingsController < BaseController

  # ---- breadcrumbs ----

  add_breadcrumb I18n.t('field_mapping.title'), :collection_path

  # ---- methods ----
  def index
  end

  def show
    add_breadcrumb 'Show', :resource_path
  end

end
