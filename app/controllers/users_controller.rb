class UsersController < BaseController

  # ---- breadcrumbs ----

  add_breadcrumb 'Users', :collection_path

  # ---- methods ----

  def index
    @field_mapper = FieldMapping.find_by(name: 'users')
    if params[:job].present?
      @import = FileImport.find_by(job_id: params[:job])
    end
    respond_to do |format|
      format.html
      format.json { render json: UserDatatable.new(params, view_context: view_context, current_user: current_user) }
    end
  end

  def show
    add_breadcrumb 'Show', :resource_path
    @user = @user.decorate
  end

  def new
    add_breadcrumb 'New', :new_resource_path

    @user = User.new
  end

  def create
    create! do  |success, failure|
      success.html {redirect_to user_url(@user)}
      failure.html {
        flash[:alert] = @user.errors.full_messages.join(', ') if @user.errors.present?
        render 'new'
      }
    end
  end

  def edit
    add_breadcrumb 'Edit', :edit_resource_path
    @user = @user.decorate

    resource.build_addresses if resource.addresses.blank?
  end

  def status
    user = User.find(params[:id])
    if user
      user.active!
    end
  end

  def import
    ImportWorker.perform_async(params[:import_id], current_user.id, FileImport::USERS)
    render json: {status: 'Success'}, status: HTTP::OK and return
  end

  private

  def user_params
    params.require(:user).permit!
  end
end
