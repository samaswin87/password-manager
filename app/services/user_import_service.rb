class UserImportService < ApplicationService

  def initialize(import_id, fiel_maps)
    @import_id = import_id
    @fiel_maps = fiel_maps
  end

  def call
    import = FileImport.find(@import_id)
    csv_processed = SmarterCSV.process(import.data.path, options)
    csv_processed.each do |batch|
      batch.each do |row|
        puts row
      end
    end
  end

  private

  # https://github.com/tilo/smarter_csv/blob/master/lib/smarter_csv/options_processing.rb
  def options
    {force_utf8: true, chunk_size: 100, convert_values_to_numeric: true}
  end

  def field_mapper
    {
      first_name: :first_name,
      last_name: :last_name,
      gender: :gender,
      email: :email
    }
  end
end
