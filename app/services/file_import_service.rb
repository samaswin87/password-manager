class FileImportService < ApplicationService

  def initialize(import_id)
    @import_id = import_id
    @errors = []
  end

  def call
    import = FileImport.find(@import_id)
    # ActiveStorage: open the file to get the path
    csv_processed = import.data.open do |file|
      SmarterCSV.process(file.path, options)
    end
    rows = []
    csv_processed.each do |row|
      rows << { dynamic_fields: row, file_import_id: @import_id }
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
