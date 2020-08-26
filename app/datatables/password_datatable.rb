class PasswordDatatable < ApplicationDatatable

  def_delegators :@view, :check_box_tag, :link_to, :edit_password_path, :resource_path, :content_tag, :concat

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id: { source: "Password.id"},
      name: { source: "Password.name", cond: :like },
      username: { source: "Password.username", cond: :like },
      url: { source: "Password.url", cond: :like },
      status: { source: "Password.active", searchable: false},
      action: { source: nil, searchable: false, orderable: false }
    }
  end

  def data
    records.map do |record|
      {
        name: record.name,
        username: record.username,
        url: record.url,
        url: record.url,
        status: status(record.status),
        DT_RowId: record.id,
        action: content_tag(:div, class: 'btn-group') do
          concat(link_to(fa_icon('eye padding-right'), resource_path(record)))
          concat(link_to(fa_icon('pencil padding-right'), edit_password_path(record)))
          concat(link_to(fa_icon('trash-o padding-right'), resource_path(record), method: :delete, data: {confirm_swal: 'Are you sure?'}))
        end
      }
    end
  end

  def status(status)
    if status == 'Active'
      content_tag(:span, class: 'label label-success') do
        status
      end
    else
      content_tag(:span, class: 'label label-danger') do
        status
      end
    end
  end

  def get_raw_records
    passwords = @current_user.admin? ? Password.all : @current_user.passwords
    status_params = params.fetch('columns',{}).fetch('3', {}).fetch('search', {}).permit(:value)
    if status_params['value'] == 'active'
      passwords = passwords.active
    elsif status_params['value'] == 'in-active'
      passwords = passwords.in_active
    end
    passwords
  end

end
