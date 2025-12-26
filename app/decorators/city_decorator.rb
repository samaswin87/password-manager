class CityDecorator < Draper::Decorator
  delegate_all

  def actions
    h.content_tag(:div, class: 'btn-group padding-right') do
      h.concat(h.link_to(h.fa_icon_with_class('trash-o', 'mr-10'), h.location_path(object),
                         method: :delete, data: { confirm_swal: 'Are you sure?' }))
    end
  end

  def status_button; end
end
