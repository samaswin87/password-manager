class UserImportServiceOld < ApplicationService

  csv_row_validate :blank => [:first_name, :last_name, :email, :gender_id, :user_type_id],
                   :email => [:email],
                   :number => [:gender_id, :user_type_id]

  def initialize(import_id, field_maps)
    @import_id = import_id
    @field_maps = field_maps.is_a?(Hash) ? field_maps.symbolize_keys : JSON.parse(field_maps.gsub('=>', ':')).symbolize_keys
    @errors = []
  end

  def call
    import = FileImport.find(@import_id)
    import.process!
    csv_processed = SmarterCSV.process(import.data.path, options)
    users = []
    user_type = UserType.user
    total_records = 0
    csv_processed.each do |batch|
      total_records = total_records + batch.count
      batch.each do |row|
        row_hash = {
          first_name: row[field_mapper[:first_name]],
          last_name: row[field_mapper[:last_name]],
          gender_id: find_gender(row[field_mapper[:gender]]).id,
          email: row[field_mapper[:email]],
          user_type_id: user_type.id
        }
        users << row_hash if validate_fields(row_hash)
      end
    end
    begin
      import.total_count!(total_records)
      import.parsed_count!(users.count)
      imports = User.import(users, on_duplicate_key_update: {conflict_target: [:email], columns: [:first_name, :last_name, :gender_id, :email]},
          batch_size: 100, raise_error: true)
      import.complete!
      import.success_count!(imports.ids.count)
      import.failed_count!(imports.failed_instances.count + @errors.count)
    rescue StandardError => e
      import.update_attribute(:error_messages, e.message)
      import.abort!
    end
  end

  private

  # https://github.com/tilo/smarter_csv/blob/master/lib/smarter_csv/options_processing.rb
  def options
    {force_utf8: true, chunk_size: 100, convert_values_to_numeric: true}
  end

  def field_mapper
    {
      first_name: @field_maps[:first_name].to_symbol,
      last_name: @field_maps[:last_name].to_symbol,
      gender: @field_maps[:gender].to_symbol,
      email: @field_maps[:email].to_symbol
    }
  end

  def find_gender(value)
    @genders_map ||= Gender.all.group_by(&:alias)
    if %w(Male Female male female).include?(value)
      @genders_map[value.downcase].first
    elsif %w(m f M F).include?(value)
      gender_name = (value.downcase == 'm') ? 'Male' : 'Female'
      @genders_map[gender_name.downcase].first
    elsif value
      @genders_map['male'].first
    else
      @genders_map['female'].first
    end
  end

end