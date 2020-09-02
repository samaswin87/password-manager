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
    job_id = UserImportWorker.perform_async(params[:id], params[:fieldMap])
    file_import = FileImport.find(params[:id])
    file_import.update_attribute(:job_id, job_id)
    render json: {job_id: job_id}, status: :ok and return
  end

  private


  def file_params
    params.permit({files: []}, :type)
  end

end
