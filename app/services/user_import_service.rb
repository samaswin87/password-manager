class UserImportService < AbstractUserImportService
  def import(import_id, _user_id)
    import = FileImport.find(import_id)
    import.process!
    users = []
    user_type_id = UserType.user.id
    import.import_data_tables.find_in_batches(batch_size: 100) do |batch|
      batch.each do |import_data|
        user_hash = {}
        import.mappings.each do |key, field|
          user_hash[key] = if key == 'gender_id'
                             find_gender(import_data.dynamic_fields[field]).try(:id)
                           else
                             import_data.dynamic_fields[field]
                           end
        end

        user_hash[:user_type_id] = user_type_id
        users << user_hash
      end
    end
    import.update!(parsed_data: users)
    import.parsed_count!(users.count)
    begin
      imports = User.import(users,
                            on_duplicate_key_update: {
                              conflict_target: [:email],
                              columns: import.mappings.keys
                            },
                            batch_size: 100,
                            raise_error: true)
      import.complete!
      import.success_count!(imports.ids.try(:count))
      import.failed_count!(imports.failed_instances.try(:count))
    rescue StandardError => e
      import.update!(error_messages: e.message)
      import.abort!
    end
  end

  def find_gender(value)
    @genders_map ||= Gender.all.group_by(&:alias)
    if %w[Male Female male female].include?(value)
      @genders_map[value.downcase].first
    elsif %w[m f M F].include?(value)
      gender_name = value.downcase == 'm' ? 'Male' : 'Female'
      @genders_map[gender_name.downcase].first
    elsif value
      @genders_map['male'].first
    else
      @genders_map['female'].first
    end
  end
end
