class UploadController < ApplicationController

  # ---- methods ----
  def users
    if params[:files].present?
      FileImport.create({
        data: params[:files].first,
        source: current_user
      });
    end
    respond_to do |format|
      format.json { head :ok }
    end
  end

end
