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

  def save_icon
    h.link_to(h.edit_user_path(object), class: 'btn btn-success') do
      h.fa_icon('save')
    end
  end

  def add_icon
    h.link_to(h.edit_user_path(object), class: 'btn btn-success') do
      h.fa_icon('plus-square')
    end
  end

  def toggle_user_type
    user_type = object.admin? ? 'Admin' : 'User'
    h.check_box_tag(:usertype, user_type, object.admin?, disabled: true, data: { toggle: 'toggle', onstyle: 'primary', offstyle: 'warning', on: 'Admin', off: 'User' } )
  end

  def toggle_gender
    h.check_box_tag(:usertype, object.gender_name, object.gender_name == 'Male', disabled: true, data: { toggle: 'toggle', onstyle: 'success', offstyle: 'danger', on: 'Male', off: 'Female' } )
  end
end
