# rake db:migrate:down VERSION=20170222202243
class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :house_name
      t.integer :number
      t.string :street
      t.string :additional_details
      t.string :zipcode
      t.references :linkable, polymorphic: true, index: true
      t.references :city, index: true, foreign_key: true
      t.references :state, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
