class FileImportDecorator < Draper::Decorator
  delegate_all

  def file_import_hash
    attributes = object.attributes.except('id', 'data_type', 'created_at', 'updated_at', 'job_id', 'data_updated_at', 'headers')
    file_import_hash = {}
    attributes.each do |key, value|
      if key == 'state'
        file_import_hash[key] = status(value)
      else
        file_import_hash[key] = value
      end
    end
    file_import_hash
  end

  def status(state)
    case state
    when 'pending',  'uploading',  'importing'
      content(state, 'label-warning')
    when 'processing', 'mapping'
      content(state, 'label-primary')
    when 'falied'
      content(state, 'label-danger')
    when 'completed'
      content(state, 'label-success')
    end
  end

  def content(state, label)
    h.content_tag(:span, class: "label #{label}") do
      state.humanize
    end
  end

end
