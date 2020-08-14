class UsersController < InheritedResources::Base
  # ---- layout ----

  layout 'admin'


  # ---- devise ----

  before_action :authenticate_user!
  load_and_authorize_resource

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

  def edit
    add_breadcrumb 'Edit', :edit_resource_path

    resource.build_address if resource.address.blank?
  end

  private

  def user_params
    params.require(:user).permit!
  end
end
