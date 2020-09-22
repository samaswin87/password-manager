class PasswordsController < BaseController

  # ---- breadcrumbs ----

  add_breadcrumb 'Passwords', :collection_path

  # ---- methods ----
  def index
    respond_to do |format|
      format.html
      format.json { render json: PasswordDatatable.new(params, view_context: view_context, current_user: current_user) }
    end
  end

  def show
    add_breadcrumb 'Show', :resource_path
    @password = @password.decorate
  end

  def new
    add_breadcrumb 'New', :new_resource_path

    @password = Password.new
  end

  def create
    @password.user_id = current_user.id
    create! do  |success, failure|
      success.html {redirect_to password_url(@password)}
      failure.html {
        flash[:alert] = @password.errors.full_messages.join(', ') if @password.errors.present?
        render 'new'
      }
    end
  end

  def edit
    add_breadcrumb 'Edit', :edit_resource_path
  end

  def status
    password = Password.find(params[:id])
    if password
      password.active!
    end
  end

  def uploads
    if params['attachments'].present?
      password = Password.find(params[:id])
      if password.present?
        params['attachments'].each do |attachment|
          password.attachments.create(attachment: attachment)
        end
      end
    end
    render json: {status: 'Success'}, status: HTTP::OK and return
  end

  def remove_attachment
    password = Password.find(params[:id])
    if password
      attachment = password.attachments.find(params[:attachment_id])
      attachment.destroy
    end
    redirect_to action: 'show'
  end

  def import
    ImportWorker.perform_async(params[:import_id], FileImport::PASSWORDS)
    render json: {status: 'Success'}, status: HTTP::OK and return
  end

  private

  def password_params
    params.require(:password).permit!
  end

end
