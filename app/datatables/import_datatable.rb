class ImportDatatable < ApplicationDatatable

  def_delegators :@view, :check_box_tag, :link_to, :resource_path, :content_tag, :concat

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id: { source: "FileImport.id"},
      data_file_name: { source: "FileImport.data_file_name", cond: :like },
      data_content_type: { source: "FileImport.data_content_type", searchable: false},
      source_type: { source: "FileImport.source_type", searchable: false },
      data_updated_on: { source: "FileImport.data_updated_at", searchable: false },
      completed_on: { source: "FileImport.completed_at", searchable: false },
      status: { source: "FileImport.state", searchable: false },
      counts: { source: nil, searchable: false },
    }
  end

  def data
    records.map do |record|
      {
        data_file_name: record.data_file_name,
        data_content_type: record.data_content_type,
        source_type: record.source_type,
        data_updated_on: record.data_updated_at.date_only,
        completed_on: record.completed_at.date_only,
        status: record.state,
        DT_RowId: record.id,
        counts: ''
      }
    end
  end

  def get_raw_records
    FileImport
  end

end
