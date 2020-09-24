# rake db:migrate:down VERSION=20200916163314
class ModifyFileImportDataType < ActiveRecord::Migration[5.2]
  def change
    remove_reference :file_imports, :source
    remove_column :file_imports, :source_type
    add_column :file_imports, :data_type, :string
    add_column :file_imports, :headers, :string, array: true, default: []
    add_column :file_imports, :mappings, :jsonb, null:false, default: {}
  end
end
