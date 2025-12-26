class FileImportDecorator < Draper::Decorator
  delegate_all

  def file_import_hash
    attributes = object.attributes.except('id', 'data_type', 'created_at', 'updated_at', 'job_id', 'data_updated_at',
                                          'headers')
    file_import_hash = {}
    attributes.each do |key, value|
      file_import_hash[key] = if key == 'state'
                                status
                              else
                                value
                              end
    end
    file_import_hash
  end

  def status
    case object.state
    when 'pending', 'uploading', 'importing'
      content('label-warning')
    when 'processing', 'mapping'
      content('label-primary')
    when 'falied'
      content('label-danger')
    when 'completed'
      content('label-success')
    end
  end

  def content(label)
    h.content_tag(:span, class: "label #{label}") do
      object.state.humanize
    end
  end
end
