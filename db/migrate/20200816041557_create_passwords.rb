# rake db:migrate:down VERSION=20200816041557
class CreatePasswords < ActiveRecord::Migration[5.2]
  def change
    create_table :passwords do |t|
      t.string :name
      t.string :url
      t.string :username
      t.string :password
      t.string :key
      t.text :ssh
      t.text :details
      t.attachment :attachment
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
