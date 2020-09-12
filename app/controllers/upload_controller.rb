class UploadController < ApplicationController

  # ---- methods ----
  def create
    attr = file_params
    if (attr[:type] == 'user').present?
      source_type = 'User'
    elsif (attr[:type] == 'password').present?
      source_type = 'Password'
    end

    if source_type
      file_import = FileImport.create({
        data: attr[:files].first,
        source_type: source_type
      });
      render json: file_import.id and return
    end

    render json: 'Wrong type', status: HTTP::BAD_REQUEST and return
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
