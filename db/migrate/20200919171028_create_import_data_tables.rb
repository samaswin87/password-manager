# rake db:migrate:down VERSION=20200919171028
class CreateImportDataTables < ActiveRecord::Migration[5.2]
  def change
    create_table :import_data_tables do |t|
      t.jsonb :dynamic_fields
      t.references :file_import, index: true, foreign_key: true
      t.timestamps
    end

    add_index :import_data_tables, :dynamic_fields, using: :gin
  end
end
