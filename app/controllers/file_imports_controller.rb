class FileImportsController < BaseController

  # ---- breadcrumbs ----

  add_breadcrumb 'File Imports', :collection_path

  # ---- methods ----
  def index
    respond_to do |format|
      format.html
      format.json { render json: ImportDatatable.new(params, view_context: view_context, current_user: current_user) }
    end
  end

  def show
    add_breadcrumb 'Show', :resource_path
    if params[:page] && params[:page] == 'mapper'
      @page = params[:page]
      @field_mapper = FieldMapping.find_by(name: resource.data_type)
    else
      @file_import_hash = resource.attributes.except('id', 'data_type', 'created_at', 'updated_at', 'job_id', 'data_updated_at')
    end
  end

end
