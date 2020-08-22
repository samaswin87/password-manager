class CitiesController < BaseController

  # ---- breadcrumbs ----

  add_breadcrumb 'Cities', :collection_path

  # ---- methods ----
  def index
    respond_to do |format|
      format.html
      format.json { render json: CityDatatable.new(params, view_context: view_context, current_user: current_user) }
    end
  end

  def show
    add_breadcrumb 'Show', :resource_path
  end

  def new
    add_breadcrumb 'New', :new_resource_path

    @city = City.new
  end

  def create
    create! do  |success, failure|
      success.html {redirect_to city_url(@city)}
      failure.html {
        flash[:alert] = @city.errors.full_messages.join(', ') if @city.errors.present?
        render 'new'
      }
    end
  end

  def edit
    add_breadcrumb 'Edit', :edit_resource_path
  end

  private

  def city_params
    params.require(:city).permit!
  end
end
