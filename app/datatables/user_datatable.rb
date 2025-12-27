class UserDatatable < ApplicationDatatable
  def_delegators :@view, :check_box_tag, :link_to, :edit_user_path, :resource_path, :content_tag, :concat, :fa_icon

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id: { source: 'User.id' },
      first_name: { source: 'User.first_name', cond: :like },
      last_name: { source: 'User.last_name', cond: :like },
      email: { source: 'User.email', cond: :like },
      phone: { source: 'User.phone', cond: :like },
      gender: { source: 'Gender.name', searchable: false },
      type: { source: 'UserType.name', searchable: false },
      status: { source: 'User.active', searchable: false },
      action: { source: nil, searchable: false, orderable: false }
    }
  end

  def data
    records.map do |record|
      {
        first_name: record.first_name,
        last_name: record.last_name,
        phone: record.phone,
        email: record.email,
        gender: record.gender_name,
        type: record.user_type_name,
        DT_RowId: record.id,
        status: status(record.active),
        action: content_tag(:div, class: 'btn-group') do
          concat(link_to(fa_icon('eye padding-right'), resource_path(record)))
          concat(link_to(fa_icon('pencil padding-right'), edit_user_path(record)))
        end
      }
    end
  end

  def status(active)
    if active
      content_tag(:span, class: 'label label-success') do
        'Active'
      end
    else
      content_tag(:span, class: 'label label-danger') do
        'InActive'
      end
    end
  end

  def get_raw_records
    users = User.includes(:user_type, :gender).all
    status_params = params.fetch('columns', {}).fetch('6', {}).fetch('search', {}).permit(:value, :regex)
    if status_params['value'] == 'active'
      users = users.active
    elsif status_params['value'] == 'in-active'
      users = users.in_active
    end
    users
  end
end
