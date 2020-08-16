class StatesController < InheritedResources::Base

  # ---- layout ----

  layout 'admin'
  # ---- devise ----

  before_action :authenticate_user!
  load_and_authorize_resource

  # ---- breadcrumbs ----

  add_breadcrumb 'States', :collection_path

  # ---- methods ----
  def index
    respond_to do |format|
      format.html
      format.json { render json: StateDatatable.new(params, view_context: view_context, current_user: current_user) }
    end
  end

  def show
    add_breadcrumb 'Show', :resource_path
  end

  def new
    add_breadcrumb 'New', :new_resource_path

    @state = State.new
  end

  def edit
    add_breadcrumb 'Edit', :edit_resource_path
  end

  private

  def state_params
    params.require(:state).permit!
  end
end
