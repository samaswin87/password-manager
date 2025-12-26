class FieldMappingsController < BaseController
  # ---- breadcrumbs ----

  add_breadcrumb I18n.t('field_mapping.title'), :collection_path

  # ---- methods ----
  def index
    @supported_tables = supported_tables
    @name = params[:name]
    field_mapping = if @name.present?
                      FieldMapping.find_by(name: params[:name])
                    else
                      FieldMapping.find_by(name: 'passwords')
                    end
    @available_fields = field_mapping.available_fields if field_mapping
    @columns = columns(@name || 'passwords')
  end

  def create_or_update
    field_name = field_params[:name].presence || 'passwords'
    field_mapping = FieldMapping.find_or_create_by(name: field_name)
    if field_mapping && field_params[:field]
      fields = field_mapping.fields || {}
      fields[field_params[:field]] = fields[field_params[:field]].blank?
      field_mapping.update!(fields: fields)
      render json: { status: 'Success' }, status: HTTP::OK and return
    end
    render json: { errors: field_mapping.errors }, status: HTTP::BAD_REQUEST and return
  end

  private

  def field_params
    params.require(:field_mapping).permit(:name, :field)
  end

  def supported_tables
    %i[passwords users locations]
  end

  def columns(table)
    return [] if table.blank?

    columns = []
    if ['locations'].include?(table)
      columns = %w[country_name country_alias state_name city_name]
    else
      klass_name = table.camelize.singularize(:en)
      columns = klass_name.constantize.importable_columns if klass_name.constantize
    end
    columns
  end
end
