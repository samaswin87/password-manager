class PasswordsController < BaseController
  # ---- breadcrumbs ----

  add_breadcrumb 'Passwords', :collection_path

  # ---- methods ----
  def index
    respond_to do |format|
      format.html
      format.json do
        passwords = current_user.admin? ? Password.all : current_user.passwords
        passwords = passwords.order(updated_at: :desc)

        # Apply search filter if present
        if params[:search].present?
          search_term = "%#{params[:search]}%"
          passwords = passwords.where(
            'name LIKE ? OR username LIKE ? OR url LIKE ? OR email LIKE ?',
            search_term, search_term, search_term, search_term
          )
        end

        # Apply status filter
        case params[:filter]
        when 'active'
          passwords = passwords.where(active: true)
        when 'inactive'
          passwords = passwords.where(active: false)
        end

        @pagy, @passwords = pagy(passwords, items: 12)

        render json: {
          data: @passwords.map { |p| PasswordDatatable.format_password(p, view_context) },
          pagy: pagy_metadata(@pagy)
        }
      end
    end
  end

  def show
    add_breadcrumb 'Show', :resource_path
    @password = @password.decorate
  end

  def new
    add_breadcrumb 'New', :new_resource_path

    @password = Password.new
  end

  def edit
    add_breadcrumb 'Edit', :edit_resource_path
  end

  def create
    @password.user_id = current_user.id
    create! do |success, failure|
      success.html { redirect_to password_url(@password) }
      failure.html do
        flash[:alert] = @password.errors.full_messages.join(', ') if @password.errors.present?
        render 'new'
      end
    end
  end

  def status
    password = Password.find(params[:id])
    return unless password

    password.active!
  end

  def uploads
    if params['attachments'].present?
      password = Password.find(params[:id])
      if password.present?
        params['attachments'].each do |attachment|
          password.attachments.create(attachment: attachment)
        end
      end
    end
    render json: { status: 'Success' }, status: HTTP::OK and return
  end

  def remove_attachment
    password = Password.find(params[:id])
    if password
      attachment = password.attachments.find(params[:attachment_id])
      attachment.destroy
    end
    redirect_to action: 'show'
  end

  def import
    ImportWorker.perform_async(params[:import_id], current_user.id, FileImport::PASSWORDS)
    render json: { status: 'Success' }, status: HTTP::OK and return
  end

  private

  def password_params
    params.require(:password).permit(
      :name,
      :url,
      :username,
      :email,
      :text_password,
      :key,
      :ssh_private_key,
      :ssh_public_key,
      :ssh_finger_print,
      :details,
      :logo,
      :attachment
    )
  end
end
