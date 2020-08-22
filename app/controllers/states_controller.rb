class StatesController < BaseController

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

  def create
    create! do  |success, failure|
      success.html {redirect_to state_url(@state)}
      failure.html {
        flash[:alert] = @state.errors.full_messages.join(', ') if @state.errors.present?
        render 'new'
      }
    end
  end

  def edit
    add_breadcrumb 'Edit', :edit_resource_path
  end

  private

  def state_params
    params.require(:state).permit!
  end
end
