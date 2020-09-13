class FieldMappingsController < BaseController

  # ---- breadcrumbs ----

  add_breadcrumb I18n.t('field_mapping.title'), :collection_path

  # ---- methods ----
  def index
    @supported_tables = supported_tables
    @type = params[:type]
    @columns = columns(@type)
  end

  private

  def supported_tables
    [:passwords, :users, :states, :cities]
  end

  def columns(table)
    return [] unless table.present?
    columns = []
    klass_name = table.camelize.singularize(:en)
    if klass_name.constantize
      columns = klass_name.constantize.column_names
    end
    columns
  end

end
