class UserDecorator < Draper::Decorator
  delegate_all

  def status_button
    if object.active?
      h.content_tag(:button, class: 'btn btn-success', id: 'user_status') do
        h.fa_icon('unlock')
      end
    else
      h.content_tag(:button, class: 'btn btn-danger', id: 'user_status') do
        h.fa_icon('lock')
      end
    end
  end

  def edit_icon
    h.link_to(h.edit_user_path(object), class: 'btn btn-success') do
      h.fa_icon('edit')
    end
  end
end
