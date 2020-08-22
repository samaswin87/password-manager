class UsersController < BaseController

  # ---- breadcrumbs ----

  add_breadcrumb 'Users', :collection_path

  # ---- methods ----

  def index
    respond_to do |format|
      format.html
      format.json { render json: UserDatatable.new(params, view_context: view_context, current_user: current_user) }
    end
  end

  def show
    add_breadcrumb 'Show', :resource_path
  end

  def new
    add_breadcrumb 'New', :new_resource_path

    @user = User.new
    @user.build_address
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

    resource.build_address if resource.address.blank?
  end

  private

  def user_params
    params.require(:user).permit!
  end
end
