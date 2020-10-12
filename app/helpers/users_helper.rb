module UsersHelper

  def href_fa_icon_with_class(icon, href)
    content_tag(:a, href: "#{href}", class: "pr-10p") do
      content_tag(:i, class: "fa fa-#{icon} text-white") {}
    end
  end

  def href_fa_icon_with_class_delete(icon, href)
    content_tag(:a, href: "#{href}", class: "pr-10p", method: :delete, data: {confirm_swal: 'Are you sure?'}) do
      content_tag(:i, class: "fa fa-#{icon} text-white") {}
    end
  end

  def submit_fa_icon_with_class(icon, href)
    content_tag(:a, href: "#{href}", class: "pr-10p", data: { 'submit-form': true }) do
      content_tag(:i, class: "fa fa-#{icon} text-white") {}
    end
  end

end
