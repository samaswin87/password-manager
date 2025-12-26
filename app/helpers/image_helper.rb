# app/helpers/image_helper.rb
module ImageHelper
  # Standard image sizes matching old Paperclip styles
  SIZES = {
    icon: [32, 32],
    thumb: [60, 60],
    medium: [120, 120],
    large: [230, 230]
  }.freeze

  def attachment_image_tag(attachment, size: :medium, **)
    return image_tag('/vendor/images/img_placeholder.png', **) unless attachment.attached?

    dimensions = SIZES[size] || SIZES[:medium]
    variant = attachment.variant(resize_to_limit: dimensions)

    image_tag(variant, **)
  end

  # For User avatars
  def avatar_image_tag(user, size: :medium, **)
    attachment_image_tag(user.avatar, size: size, **)
  end

  # For Password logos
  def logo_image_tag(password, size: :medium, **)
    attachment_image_tag(password.logo, size: size, **)
  end
end
