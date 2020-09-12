class FieldMappingsController < BaseController

  # ---- breadcrumbs ----

  add_breadcrumb I18n.t('field_mapping.title'), :collection_path

  # ---- methods ----
  def index
    respond_to do |format|
      format.html
      format.json { render json: CityDatatable.new(params, view_context: view_context, current_user: current_user) }
    end
  end

  def show
    add_breadcrumb 'Show', :resource_path
  end

end
