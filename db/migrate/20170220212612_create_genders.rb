class CreateGenders < ActiveRecord::Migration[5.2]
  def change
    create_table :genders do |t|
      t.string :name
      t.string :alias

      t.timestamps null: false
    end
  end
end
