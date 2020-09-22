class PasswordImportService < AbstractPasswordImportService

  def import(import_id)
    import = FileImport.find(import_id)
    field_mapper = FieldMapping.password_mapper.first
    passwords = []
    import.import_data_tables.find_in_batches(batch_size: 100) do |batch|
      batch.each do |import_data|
        passwords << import_data.dynamic_fields
      end
    end
    puts passwords.count
  end

end
