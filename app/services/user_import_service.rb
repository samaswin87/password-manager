class UserImportService < ApplicationService

  def initialize(import_id)
    @import_id = import_id
  end

  def call
    import = FileImport.find(@import_id)
    csv_processed = SmarterCSV.process(import.data.path)
    puts "csv_processed: #{csv_processed}"
  end

end
