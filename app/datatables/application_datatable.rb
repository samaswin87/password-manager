class ApplicationDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def initialize(params, opts = {})
    @view = opts[:view_context]
    @current_user = opts[:current_user]
    super
  end

  def additional_data
    {
      draw: params[:draw].try(:to_i)
    }
  end

  def fa_icon(icon)
    content_tag(:i, class: "fa fa-#{icon}") {}
  end
end
