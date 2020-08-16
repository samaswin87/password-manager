class CityDatatable < ApplicationDatatable

  def_delegators :@view, :check_box_tag, :link_to, :edit_city_path, :resource_path, :content_tag, :concat

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id: { source: "City.id"},
      name: { source: "City.name", cond: :like },
      created_at: { source: "City.created_at", searchable: false},
      updated_at: { source: "City.updated_at", searchable: false },
      action: { source: nil, searchable: false, orderable: false }
    }
  end

  def data
    records.map do |record|
      {
        name: record.name,
        created_at: record.created_on,
        updated_at: record.updated_on,
        DT_RowId: record.id,
        action: content_tag(:div, class: 'btn-group') do
          concat(link_to(fa_icon('eye padding-right'), resource_path(record)))
          concat(link_to(fa_icon('pencil padding-right'), edit_city_path(record)))
          concat(link_to(fa_icon('trash-o padding-right'), resource_path(record), method: :delete, data: {confirm_swal: 'Are you sure?'}))
        end
      }
    end
  end

  def get_raw_records
    City.all
  end

end
