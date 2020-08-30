class UserImportService < ApplicationService

  def initialize(import_id, field_maps)
    @import_id = import_id
    @field_maps = JSON.parse(field_maps.gsub('=>', ':'))
  end

  def call
    import = FileImport.find(@import_id)
    csv_processed = SmarterCSV.process(import.data.path, options)
    csv_processed.each do |batch|
      users = []
      batch.each do |row|
        users << {
          first_name: row[field_mapper[:first_name]],
          last_name: row[field_mapper[:last_name]],
          gender: row[field_mapper[:gender]],
          email: row[field_mapper[:email]],
        }
      end
      puts users
    end
  end

  private

  # https://github.com/tilo/smarter_csv/blob/master/lib/smarter_csv/options_processing.rb
  def options
    {force_utf8: true, chunk_size: 100, convert_values_to_numeric: true}
  end

  def field_mapper
    {
      first_name: @field_maps['first_name'].to_symbol,
      last_name: @field_maps['last_name'].to_symbol,
      gender: @field_maps['gender'].to_symbol,
      email: @field_maps['email'].to_symbol
    }
  end
end
