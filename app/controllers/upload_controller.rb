class UploadController < ApplicationController

  # ---- methods ----
  def create
    attr = file_params
    if (attr[:type] == 'user').present?
      file_import = FileImport.create({
        data: attr[:files].first,
        source: current_user
      });
    end
    render json: file_import.id and return
  end

  def import
    UserImportWorker.perform_async(params[:id], params[:fieldMap])
    render json: {success: true} ,status: :ok and return
  end

  private

  def file_params
    params.permit({files: []}, :type)
  end

end
