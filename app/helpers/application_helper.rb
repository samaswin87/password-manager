module ApplicationHelper
  include Pagy::Frontend

  # ---- icons and labels -----

  def fa_icon(icon)
    content_tag(:i, class: "fa-solid fa-#{icon}") {}
  end

  def menu_label_icon(text, icon)
    content_tag(:i, class: "fa-solid fa-#{icon}") {} +
      content_tag(:span) do
        text
      end
  end

  def menu_label_icon_with_class(text, icon, klass)
    content_tag(:i, class: "fa-solid fa-#{icon} #{klass}") {} +
      content_tag(:span) do
        text
      end
  end

  def fa_icon_with_class(icon, klass)
    content_tag(:i, class: "fa-solid fa-#{icon} #{klass}") {}
  end

  # ---- sortable table headers ----

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == params[:sort] && params[:direction] == 'asc' ? 'desc' : 'asc'
    icon = if column == params[:sort]
             content_tag(:i, '', class: "fa-solid fa-sort-#{params[:direction] == 'asc' ? 'up' : 'down'}")
           else
             ''
           end

    link_to url_for(params.permit(:query, :status, :sort, :direction, :page).merge(sort: column, direction: direction)),
            data: { turbo_frame: 'users_table' } do
      "#{title} #{icon}".html_safe
    end
  end

  # ---- simple form ----

  def deal_value(value, format = :default)
    if [Date, Time, ActiveSupport::TimeWithZone].include?(value.class)
      value.blank? ? '-' : l(value, format: format)
    elsif [TrueClass, FalseClass].include?(value.class)
      value.humanize
    else
      value.presence || '-'
    end
  end

  # ----- resource -----

  def resource_title
    t("resources.#{resource_class.to_s.underscore}.title")
  end

  def resource_description
    t("resources.#{resource_class.to_s.underscore}.description")
  end

  def resource_label_pluralized
    resource_label.pluralize
  end

  def new_resource_label
    t("resources.#{resource_class.to_s.underscore}.new")
  end

  def edit_resource_label
    t("resources.#{resource_class.to_s.underscore}.edit")
  end

  # ---- block on partial ----

  def block_to_partial(partial_name, options = {}, &)
    options[:body] = capture(&)
    render(partial: partial_name, locals: options)
  end

  # ---- bootstrap defaults ----

  def bootstrap_box(title, icon, actions = nil, options = {}, &)
    block_to_partial('shared/bootstrap_box', options.merge(title: title, icon: icon, actions: actions), &)
  end

  def bootstrap_button_new(options = {})
    title = options.delete(:title) || new_resource_label

    path = if defined? parent
             options.delete(:url) || new_resource_path(parent.id)
           else
             options.delete(:url) || new_resource_path
           end

    path = options[:page] unless options[:page].nil?

    icon = options.delete(:icon) || 'plus'
    css_class = options.delete(:class) || 'btn btn-default pull-right'
    id = options.delete(:id)

    options[:class] = css_class
    options[:id] = id

    link_to(path, options) do
      fa_icon(icon) + " #{title}"
    end
  end

  # ---- flash messages ----

  def custom_bootstrap_flash
    types = { 'notice' => 'success', 'info' => 'info', 'warning' => 'warning', 'alert' => 'error' }
    titles = { 'notice' => 'Success', 'info' => 'Message', 'warning' => 'Warning', 'alert' => 'Alert' }

    flash_messages = []

    flash.each do |type, message|
      next unless types.key?(type)

      text = "<script>
      if (typeof showNotification !== 'undefined') {
        showNotification('#{types[type]}', 'top right', '#{titles[type]}', '#{escape_javascript(message)}');
      }
      </script>"
      flash_messages << text.html_safe if message
    end

    flash_messages.join("\n").html_safe
  end

  # NOTE: https://coderwall.com/p/a1pj7w/rails-page-titles-with-the-right-amount-of-magic
  def title
    if content_for?(:title)
      # allows the title to be set in the view by using t(".title")
      content_for :title
    else
      # look up translation key based on controller path, action name and .title
      # this works identical to the built-in lazy lookup
      t("#{controller_path.tr('/', '.')}.#{action_name}.title", default: :title)
    end
  end

  def show_image(_record)
    if current_user.avatar.attached?
      variant_url = url_for(current_user.avatar.variant(resize_to_limit: [60, 60]))
      "<img src=#{variant_url} class='img-circle profile-user-img' loading='lazy' />"
    else
      "<div class='profile-user-img img-circle profile-icon-placeholder'>
        <i class='fa-solid fa-user'></i>
      </div>"
    end
  end
end
