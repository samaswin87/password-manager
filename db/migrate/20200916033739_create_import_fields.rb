# rake db:migrate:down VERSION=20200916033739
class CreateImportFields < ActiveRecord::Migration[5.2]
  def change
    create_table :import_fields do |t|
      t.references :file_import, index: true, foreign_key: true
      t.timestamps
    end
  end
end
