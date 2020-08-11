module ApplicationHelper
  # ---- icons and labels -----

  def fa_icon(icon)
    content_tag(:i, class: "fa fa-#{icon}") {}
  end

  def menu_label_icon(text, icon)
    content_tag(:i, class: "fa fa-#{icon}") {} +
      content_tag(:span) do
        text
      end
  end

  # ---- simple form ----

  def deal_value(value, format = :default)
    if [Date, Time, ActiveSupport::TimeWithZone].include?(value.class)
      value.blank? ? '—' : l(value, format: format)
    elsif [TrueClass, FalseClass].include?(value.class)
      value.humanize
    else
      value.blank? ? '-' : value
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

  def block_to_partial(partial_name, options = {}, &block)
    options[:body] = capture(&block)
    render(partial: partial_name, locals: options)
  end

  # ---- bootstrap defaults ----

  def bootstrap_box(title, icon, actions = nil, options = {}, &block)
    block_to_partial('shared/bootstrap_box', options.merge(title: title, icon: icon, actions: actions), &block)
  end

  def bootstrap_button_new(options = {})
    title = options.delete(:title) || new_resource_label

    if defined? parent
      path = options.delete(:url) || new_resource_path(parent.id)
    else
      path = options.delete(:url) || new_resource_path
    end

    icon = options.delete(:icon) || 'plus'
    css_class = options.delete(:class) || 'btn btn-default btn-xs pull-right'
    id = options.delete(:id)

    options[:class] = css_class
    options[:id] = id

    link_to(path, options) do
      fa_icon(icon) + ' ' + title
    end
  end

  # ---- flash messages ----

  def custom_bootstrap_flash
    types = { 'notice' => 'success', 'info' => 'info', 'warning' => 'warning', 'alert' => 'error' }
    titles = { 'notice' => 'Sucesso', 'info' => 'Mensagem', 'warning' => 'Advertência', 'alert' => 'Atenção' }

    flash_messages = []

    flash.each do |type, message|
      next unless types.key?(type)
      text = "<script>
      $.notify.autoHideNotify('#{types[type]}', 'top right', '#{titles[type]}','#{message}');
      </script>"
      flash_messages << text.html_safe if message
    end

    flash_messages.join("\n").html_safe
  end
end
