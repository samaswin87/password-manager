class FieldMappingsController < BaseController

  # ---- breadcrumbs ----

  add_breadcrumb I18n.t('field_mapping.title'), :collection_path

  # ---- methods ----
  def index
    @supported_tables = supported_tables
    @name = params[:name]
    if @name.present?
      field_mapping = FieldMapping.find_by(name: params[:name])
    else
      field_mapping = FieldMapping.find_by(name: 'passwords')
    end
    @available_fields = field_mapping.available_fields if field_mapping
    @columns = columns(@name || 'passwords')
  end

  def create_or_update
    field_mapping = FieldMapping.find_or_create_by(name: field_params[:name])
    if field_mapping && field_params[:field]
      fields = field_mapping.fields || {}
      fields[field_params[:field]] = !fields[field_params[:field]].present?
      field_mapping.update_attribute(:fields, fields)
      render json: {status: 'Success'}, status: HTTP::OK and return
    end
    render json: {errors: field_mapping.errors}, status: HTTP::BAD_REQUEST and return
  end

  private

  def field_params
     params.require(:field_mapping).permit(:name, :field)
  end

  def supported_tables
    [:passwords, :users, :states, :cities]
  end

  def columns(table)
    return [] unless table.present?
    columns = []
    klass_name = table.camelize.singularize(:en)
    if klass_name.constantize
      columns = klass_name.constantize.importable_columns
    end
    columns
  end

end
