class UserDatatable < ApplicationDatatable

  def_delegators :@view, :check_box_tag, :link_to, :edit_user_path, :resource_path, :content_tag, :concat

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id: { source: "User.id"},
      first_name: { source: "User.first_name", cond: :like },
      last_name: { source: "User.last_name", cond: :like },
      email: { source: "User.email", cond: :like },
      phone: { source: "User.phone", cond: :like },
      gender: { source: "Gender.name", searchable: false},
      type: { source: "UserType.name", searchable: false},
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
        action: content_tag(:div, class: 'btn-group') do
          concat(link_to(fa_icon('eye padding-right'), resource_path(record)))
          concat(link_to(fa_icon('pencil padding-right'), edit_user_path(record)))
          unless record.user_type_name == 'Administrator'
            concat(link_to(fa_icon('trash-o padding-right'), resource_path(record), method: :delete, data: {confirm_swal: 'Are you sure?'}))
          end
        end
      }
    end
  end

  def get_raw_records
    User.valid.includes(:user_type, :gender)
  end

end
