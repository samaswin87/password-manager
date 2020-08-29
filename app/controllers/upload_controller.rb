class UploadController < ApplicationController

  # ---- methods ----
  def users
    if params[:files].present?
      file_import = FileImport.create({
        data: params[:files].first,
        source: current_user
      });

      UserImportWorker.perform_async(file_import.id)
    end
    render json: file_import.id and return
  end

end
