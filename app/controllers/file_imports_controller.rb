class FileImportsController < BaseController
  actions :all, :except => [ :remove_record ]

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
    if params[:page]
      @page = params[:page]
      if params[:page] == 'mapper'
        resource.map!
        @field_mapper = FieldMapping.find_by(name: resource.data_type)
      elsif params[:page] == 'records'
        respond_to do |format|
          format.html
          format.json { render json: ImportRecordsDatatable.new(params, view_context: view_context, current_user: current_user, resource: resource) }
        end
      end
    else
      resource.import! if resource.state == 'uploading'
      @file_import_decorator = resource.decorate
    end
  end

  def update
    unless resource.mappings.present?
      resource.update_attribute(:mappings, params[:field_maps])
      FileImportWorker.perform_async(resource.id)
    end

    render json: {status: 'Success'}, status: HTTP::OK and return
  end

  def remove_record
    importable = ImportDataTable.find(params[:record_id])
    importable.destroy
    redirect_back(fallback_location: root_path)
  end

end
