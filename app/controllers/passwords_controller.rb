class PasswordsController < InheritedResources::Base

  # ---- layout ----

  layout 'admin'
  # ---- devise ----

  before_action :authenticate_user!
  load_and_authorize_resource

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

  def edit
    add_breadcrumb 'Edit', :edit_resource_path
  end

  private

  def password_params
    params.require(:password).permit!
  end
end
