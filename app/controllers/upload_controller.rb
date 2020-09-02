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
    job_status = JobStatus.create(job_id: job_id)
    file_import.update_attribute(:job_status_id, job_status.id)
    render json: {success: true} ,status: :ok and return
  end

  private


  def file_params
    params.permit({files: []}, :type)
  end

end
