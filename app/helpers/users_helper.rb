module UsersHelper

  def href_fa_icon_with_class(icon, href)
    content_tag(:a, href: "#{href}", class: "pr-10p") do
      content_tag(:i, class: "fa fa-#{icon} text-white") {}
    end
  end

end
