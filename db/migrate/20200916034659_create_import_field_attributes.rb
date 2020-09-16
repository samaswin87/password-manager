class CreateImportFieldAttributes < ActiveRecord::Migration[5.2]
  def change
    create_table :import_field_attributes do |t|
      t.json :attributes
      t.references :file_import, index: true, foreign_key: true
      t.timestamps
    end
  end
end
