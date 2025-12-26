class PasswordDatatable
  # Static helper methods for formatting password data
  # Used by PasswordsController for JSON API responses

  def self.format_password(record, view_context)
    {
      name: record.name,
      username: record.username,
      url: record.url,
      email: record.email,
      status: record.status,
      DT_RowId: record.id,
      logo: format_logo(record, view_context)
    }
  end

  def self.format_logo(record, view_context)
    if record.logo.attached?
      view_context.image_tag(record.logo.variant(resize_to_limit: [32, 32]), size: '32x32', loading: 'lazy')
    else
      view_context.image_tag('/vendor/images/img_placeholder.png', size: '32x32', loading: 'lazy')
    end
  end
end
