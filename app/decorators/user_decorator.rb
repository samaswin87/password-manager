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
end
