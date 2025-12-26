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

  def toggle_user_type
    user_type = object.admin? ? 'Admin' : 'User'
    h.content_tag(:div, class: 'form-check form-switch') do
      h.check_box_tag(:usertype, user_type, object.admin?, disabled: true, class: 'form-check-input',
                                                           id: 'usertype_switch') +
        h.content_tag(:label, user_type, class: 'form-check-label', for: 'usertype_switch')
    end
  end

  def toggle_gender
    gender_label = object.gender_name || 'Unknown'
    h.content_tag(:div, class: 'form-check form-switch') do
      h.check_box_tag(:gender, gender_label, object.gender_name == 'Male', disabled: true, class: 'form-check-input',
                                                                           id: 'gender_switch') +
        h.content_tag(:label, gender_label, class: 'form-check-label', for: 'gender_switch')
    end
  end
end
