class ImportRecordsDatatable < ApplicationDatatable

  def_delegators :@view, :check_box_tag, :link_to, :resource_path, :content_tag, :concat

  def initialize(params, opts = {})
    @resource = opts[:resource]
    super
  end



  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id: { source: "ImportField.id"},
    }
  end

  def data
    records.map do |record|
      {
        DT_RowId: record.id,
      }
    end
  end

  def get_raw_records
    @resource.import_data_tables || []
  end

end
