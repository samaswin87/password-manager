class UsersController < InheritedResources::Base
  # ---- layout ----

  layout 'admin'

  # ---- devise ----

  before_filter :authenticate_user!
  load_and_authorize_resource

  # ---- breadcrumbs ----

  add_breadcrumb 'Usuários', :collection_path

  # ---- methods ----

  def index
    respond_to do |format|
      format.html
      format.json { render json: UserDatatable.new(view_context) }
    end
  end

  def show
    add_breadcrumb 'Detalhes', :resource_path
  end

  def new
    add_breadcrumb 'Incluir', :new_resource_path

    @user = User.new
    @user.build_address
  end

  def edit
    add_breadcrumb 'Editar', :edit_resource_path

    resource.build_address if resource.address.blank?
  end

  private

  def user_params
    params.require(:user).permit!
  end
end
