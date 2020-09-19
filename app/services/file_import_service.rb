class FileImportService < ApplicationService

  def initialize(import_id)
    @import_id = import_id
    @errors = []
  end

  def call
    import = FileImport.find(@import_id)
    csv_processed = SmarterCSV.process(import.data.path, options)
    import.process!
    rows = []
    csv_processed.each do |row|
      rows << { columns: row, file_import_id: @import_id }
    end
    begin
      ImportDataTable.import(rows, batch_size: 100, raise_error: true)
    rescue StandardError => e
      import.update_attribute(:error_messages, e.message)
    end
  end

  private

  def options
    {force_utf8: true, convert_values_to_numeric: true}
  end

end
