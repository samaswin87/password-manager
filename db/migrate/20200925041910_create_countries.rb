# rake db:migrate:down VERSION=20200925041910
class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.string :name, null: false
      t.string :alias, null: false
      t.boolean :active, default: true
      t.timestamps null: false
    end

    add_reference :states, :country, index: true
    add_reference :cities, :country, index: true
  end
end
