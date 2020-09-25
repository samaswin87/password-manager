# rake db:migrate:down VERSION=20200925041910
class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.string :name, null: false
      t.references :state, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
