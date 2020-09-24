class PasswordImportService < AbstractPasswordImportService

  def import(import_id, user_id)
    import = FileImport.find(import_id)
    import.process!
    passwords = []
    import.import_data_tables.find_in_batches(batch_size: 100) do |batch|
      batch.each do |import_data|
        password_hash = {}
        import.mappings.each do |key, field|
          password_hash[key] = import_data.dynamic_fields[field]
        end

        password_hash[:user_id] = user_id
        passwords << password_hash
      end
    end

    import.parsed_count!(passwords.count)
    begin
      imports = Password.import(passwords,
                                on_duplicate_key_update: {
                                  columns: import.mappings.keys},
                                  batch_size: 100,
                                  raise_error: true)
      import.complete!
      import.success_count!(imports.ids.try(:count) || 0)
      import.failed_count!((imports.failed_instances.try(:count) || 0) + @errors.count)
    rescue StandardError => e
      import.update_attribute(:error_messages, e.message)
      import.abort!
    end
  end

end
