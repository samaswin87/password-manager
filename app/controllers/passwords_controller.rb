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
  end

  def new
    add_breadcrumb 'New', :new_resource_path

    @password = Password.new
  end

  def create
    @password.user_id = current_user.id
    create! do  |success, failure|
      success.html {redirect_to root_url}
      failure.html {
        flash[:alert] = @password.errors.full_messages.join(', ')
        render 'new'
      }
    end
  end

  def edit
    add_breadcrumb 'Edit', :edit_resource_path
  end

  private

  def password_params
    params.require(:password).permit!
  end
end
