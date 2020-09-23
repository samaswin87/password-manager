class FileImportDecorator < Draper::Decorator
  delegate_all

  def file_import_hash
    attributes = object.attributes.except('id', 'data_type', 'created_at', 'updated_at', 'job_id', 'data_updated_at', 'headers')
    file_import_hash = {}
    attributes.each do |key, value|
      if key == 'state'
        file_import_hash[key] = status(value)
      elsif key == 'mappings'
        file_import_hash[key] = json_display(value)
      else
        file_import_hash[key] = value
      end
    end
    file_import_hash
  end

  def json_display(hash)
    h.content_tag(:div, class: 'row') do
      hash.each do |key, value|
        h.concat(
          h.content_tag(:div, class: 'col-md-3') do
            h.content_tag(:span, class: "label label-primary") do
              h.menu_label_icon_with_class(value, 'file-text-o', 'mr-5')
            end
          end
        )

        h.concat(
          h.content_tag(:div, class: 'col-md-2') do
            h.fa_icon('arrow-right')
          end
        )
        h.concat(
          h.content_tag(:div, class: 'col-md-5') do
            h.content_tag(:span, class: "label label-primary") do
              h.menu_label_icon_with_class(value, 'database', 'mr-5')
            end
          end
        )

        # h.concat(
        #   h.content_tag(:span, class: "ml-10 label label-primary") do
        #     h.menu_label_icon_with_class(value, 'file-text-o', 'mr-5')
        #   end
        # )

        # h.concat(
        #   h.content_tag(:span, class: "ml-10 label label-primary") do
        #     h.menu_label_icon_with_class(key, 'database', 'mr-3')
        #   end
        # )

        # h.concat(h.content_tag(:br))
      end
    end
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
