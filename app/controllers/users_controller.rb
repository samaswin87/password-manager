class UsersController < BaseController
  # ---- breadcrumbs ----

  add_breadcrumb 'Users', :collection_path

  # ---- methods ----

  def index
    @field_mapper = FieldMapping.find_by(name: 'users')
    @import = FileImport.find_by(job_id: params[:job]) if params[:job].present?
    respond_to do |format|
      format.html
      format.json do
        render json: UserDatatable.new(datatable_params, view_context: view_context, current_user: current_user)
      end
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

  def datatable_params
    # Permit DataTables parameters including nested regex parameters
    # DataTables sends dynamic nested structures, so we need to permit them flexibly
    permitted = params.permit(:draw, :start, :length, :form, :job, :_, search: %i[value regex])

    # Permit order parameters dynamically
    if params[:order].present?
      order_permitted = {}
      params[:order].each do |key, order|
        order_permitted[key] = order.permit(:column, :dir)
      end
      permitted[:order] = ActionController::Parameters.new(order_permitted)
    end

    # Permit columns parameters dynamically with nested search including regex
    if params[:columns].present?
      columns_permitted = {}
      params[:columns].each do |key, column|
        columns_permitted[key] = column.permit(:data, :name, :searchable, :orderable, search: %i[value regex])
      end
      permitted[:columns] = ActionController::Parameters.new(columns_permitted)
    end

    permitted
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
