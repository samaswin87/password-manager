class PasswordDecorator < Draper::Decorator
  delegate_all

  def status_button
    if object.active?
      h.content_tag(:button, class: 'btn btn-success pull-right', id: 'password_status') do
        h.fa_icon('unlock')
      end
    else
      h.content_tag(:button, class: 'btn btn-danger pull-right', id: 'password_status') do
        h.fa_icon('lock')
      end
    end
  end

  def edit_icon
    h.link_to(h.edit_password_path(object), class: 'btn btn-success') do
      h.fa_icon('edit')
    end
  end

  def delete_attachment(id)
    h.link_to(h.fa_icon('minus-circle'), h.attachment_password_path(object, {attachment_id: id}), class: 'attachment-remove', method: :delete, data: {confirm_swal: 'Are you sure?'})
  end

end
