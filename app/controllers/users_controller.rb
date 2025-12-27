class UsersController < BaseController
  # ---- breadcrumbs ----

  add_breadcrumb 'Users', :collection_path

  # ---- methods ----

  def index
    @field_mapper = FieldMapping.find_by(name: 'users')
    @import = FileImport.find_by(job_id: params[:job]) if params[:job].present?

    # Build query scope
    scope = User.includes(:user_type, :gender)

    # Apply search filter
    if params[:query].present?
      search_term = "%#{params[:query]}%"
      scope = scope.where(
        'first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ? OR phone ILIKE ?',
        search_term, search_term, search_term, search_term
      )
    end

    # Apply status filter
    scope = scope.active if params[:status] == 'active'
    scope = scope.in_active if params[:status] == 'inactive'

    # Apply sorting
    scope = scope.order(sort_column => sort_direction)

    # Paginate
    @pagy, @users = pagy(scope, items: 10)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
    add_breadcrumb 'Show', :resource_path
    @user = @user.decorate
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

  def create
    create! do |success, failure|
      success.html { redirect_to user_url(@user) }
      failure.html do
        flash[:alert] = @user.errors.full_messages.join(', ') if @user.errors.present?
        render 'new'
      end
    end
  end

  def status
    user = User.find(params[:id])
    return unless user

    user.active!
  end

  def import
    ImportWorker.perform_async(params[:import_id], current_user.id, FileImport::USERS)
    render json: { status: 'Success' }, status: HTTP::OK and return
  end

  private

  def sort_column
    valid_columns = %w[first_name last_name email phone created_at]
    valid_columns.include?(params[:sort]) ? params[:sort] : 'created_at'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :phone,
      :gender_id,
      :user_type_id,
      :avatar,
      address_attributes: %i[
        id
        street
        number
        house_name
        additional_details
        city_id
        state_id
        zipcode
        _destroy
      ]
    )
  end
end
