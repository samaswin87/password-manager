# rake db:migrate:down VERSION=20200912131244
class CreateFieldMapping < ActiveRecord::Migration[5.2]

  def change
    create_table :field_mappings do |t|
      t.json :fields
      t.string :type
      t.timestamps null: false
    end
  end
end
