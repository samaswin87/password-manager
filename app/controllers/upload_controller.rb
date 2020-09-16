class UploadController < ApplicationController

  # ---- methods ----
  def create
    attr = file_params

    file_import = FileImport.create({
      data: attr[:files].first,
      data_type: attr[:type]
    });

    if file_import.errors.present?
      render json: file_import.errors.full_messages.join(', '), status: HTTP::BAD_REQUEST and return
    end

    render json: { success:true, import_id: file_import.id } and return
  end

  def import
    job_id = UserImportWorker.perform_async(params[:id], params[:fieldMap])
    file_import = FileImport.find(params[:id])
    file_import.update_attribute(:job_id, job_id)
    render json: {job_id: job_id}, status: HTTP::OK and return
  end

  private


  def file_params
    params.permit({files: []}, :type)
  end

end
