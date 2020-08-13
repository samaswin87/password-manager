class CreateUserTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :user_types do |t|
      t.string :name
      t.string :alias

      t.timestamps null: false
    end
  end
end
